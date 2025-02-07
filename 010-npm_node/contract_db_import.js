// the goal of this program is to rewrite the contract filter program to handle many files at once and store them in a coherent manner. 
// the next goal is to be able to write these files into a postgres database. 
// then I want a simple cli interface for adding new contracts to the database.
// 
// TODO 
// > add contract number / quote number to the data
// > add client name 
// > add contract dates 
// > will create metadata files for this information -- basically this information needs to be siphoned into separate tables 
// > write a function to batch operate on every .xslx file in the current directory
//   needs to name the cleaned contract after the file it came from but with our file syntax
//   needs to put them in a single repository for cleaned contract daya
// > write a set of functions to test the cleaned contracts for errors. 
// > write a regex to pull the file name and the file path. 
//   for the file name, it should replace spaces with underscores and separate fields with hyphens
//   something like, capture from the first front slash any amount of chars until the final char
//   then, from the last char to the first encountered front slash

const XLSX = require('xlsx');

function insert_col(worksheet, columnIndex, columnData) {
   // this works on sheet objects not 2D arrays
   if (!worksheet['!ref']) {
      throw new Error('Missing valid range');
   }
   const range = XLSX.utils.decode_range(worksheet['!ref']); // get data range, ignores blank rows
   const numRows = range.e.r - range.s.r + 1;
   const startCol = columnIndex;

   // this will shift the rows to the right from the insertion point
   for (let R = range.s.r; R <= range.e.r; ++R) {
      for (let C = range.e.c; C >= startCol; --C) {
         const oldCell = XLSX.utils.encode_cell({ r: R, c: C });
         const newCell = XLSX.utils.encode_cell({ r: R, c: C + 1 });
         worksheet[newCell] = worksheet[oldCell];
         delete worksheet[oldCell];
      }
   }

   for (let R = range.s.r; R <= range.e.r; ++R) {
      const newCell = XLSX.utils.encode_cell({ r: R, c: startCol });
      worksheet[newCell] = { t: "s", v: columnData[R - range.s.r] || "" };
   }
   range.e.c += 1;
   worksheet['!ref'] = XLSX.utils.encode_range(range);
   return worksheet;
}

function filter_column_headers (data) {
   const fource_headers = ["SECTION_ID", "SPOTTING_KEY", "SIGN_COUNT", "SIGN_DESCRIPTION", "EACH_COST", "TOTAL_COST"];
   let headerRow = data[0];
   for (let i = 0; i < headerRow.length; ++i) {
      switch(headerRow[i]) {
         case "0": 
            headerRow[i] = fource_headers[0];
            break;
         case "1":
            headerRow[i] =  fource_headers[1];
            break;
         case "2":
            headerRow[i] = fource_headers[2];
            break;
         case "3":
            headerRow[i] = fource_headers[3];
            break;
         case "7":
            headerRow[i] = fource_headers[4];
            break;
         case "9":
            headerRow[i] = fource_headers[5];
            break;
         default:
            break;
      }
   }
   return data;
}

// literally just removes the first and last element of the contract. Must be a header or something. 
// this can get removed I think. 
function remove_last_subtotal (data) {
   data.pop();
   data.shift();
   return data;
}

// this uses the first column for the section name, replacing anything already in there.
// could be more generic. 
function filter_section_column (data, sectionColumn, targetColumn) {
   let currentSection = null;
   const sectionRegex = /^#\d+:/;
   const cellRegex = /\*.*$/;
   const cellPageRegex = /CONT\.?/;
   for (let i = 0; i < data.length; ++i) {
      let row = data[i];
      let sectionCell = row[sectionColumn];
      if (sectionCell && sectionRegex.test(sectionCell)) {
         currentSection = sectionCell.replace(cellRegex, "");
         currentSection = currentSection.replace(cellPageRegex, "");
         data.splice(i, 1);
         i--;
      } else if (currentSection) {
         row[targetColumn] = currentSection;
      }
   }
   return data;
}

function filter_extra_descriptions (data, targetColumn) {
   for (var i = 1; i < data.length; ++i) {
      let currentRow = data[i];
      let previousRow = data[i - 1];

      // this checks the row, matches targetColumn to the column index, checks if the cell exists, returns boolean
      let isExtraRow = currentRow.every((cell, colIndex) =>
         (colIndex === targetColumn && cell || !cell)
      );
      // this runs if isExtraRow returns true, appends the "extra" cell to the cell immediately above it
      // then deletes the now empty row and decrements the iterator to account for the mutated array.
      if (isExtraRow) {
         previousRow[targetColumn] += `- ${currentRow[targetColumn] || ''}`.trim();
         data.splice(i, 1);
         i--;
      }
   }
   return data;
}

function filter_below_match (data, term_match) {
   // find the row with the matching term, return everything ABOVE the term 
   let match_index = -1;
   for (let i = 0; i < data.length; ++i) {
      if (data[i].includes(term_match)) {
         match_index = i;
         break;
      }
   }
   const filtered_data = match_index !== -1 ? data.slice(0, match_index + 1) : data;
   return filtered_data;
}

function filter_below_match_new(data, term_match) {
   let match_index = -1;
   for (let i = 0; i < data.length; ++i) {
      if (term_match.some(term => data[i].includes(term))) {
         match_index = i;
         break;
      }
   }
   const filtered_data = match_index !== -1 ? data.slice(0, match_index + 1) : data;
   return filtered_data;
}

function filter_below_match_flex(data, term_match) 
{
   // allows for multiple types to be passed through term_match for different purposes. Consider using this pattern elsewhere. 
   let match_index = -1;
   for (let i = 0; i < data.length; ++i) {
      let isMatch = false;
      if (Array.isArray(term_match)) {
         isMatch = term_match.some(term => data[i].includes(term));
      } else if (term_match instanceof RegExp) {
         isMatch = term_match.test(data[i]);
      } else if (typeof term_match === "function") {
         isMatch = term_match(data[i]);
      } else {
         isMatch = data[i].includes(term_match);
      }
      if (isMatch) {
         match_index = i;
         break;
      }
   }
   // this part returns the data above the match
   const filtered_data = match_index !== -1 ? data.slice(0, match_index + 1) : data;
   return filtered_data;
}

function filter_above_match (data, term_match) {
   // find the row with the matching term, return everything below the term.
   let match_index = null;
   for (let i = 0; i < data.length; ++i) {
      if (data[i].includes(term_match)) {
         match_index = i;
         break;
      }
   }
   const filtered_data = match_index !== null ? data.slice(match_index + 1, data.length) : data;
   return filtered_data;
}

function contract_filter (data) {
   // filter first column, only return rows that don't contain the given string
   return data.filter(row => row[1] !== "FOURCE COMMUNICATIONS");
}

// maybe a more generic filter by rows by matching terms in a given column
function filter_rows_by_column_match(data, col_num, term_match) {
   if (typeof col_num !== 'number') throw new Error("col_num must be a number");
   return data.filter(row => row[col_num] !== `${term_match}`);
}

// for taking data in a row below where it needs to be and also in a different col and placing it into the row above in the right col
function filter_data_in_wrong_colum(data, targetColumn, properColumn) {
   for (let i = 1; i < data.length; ++i) {
      let currentRow = data[i];
      let previousRow = data[i-1];
      let cell_to_change = currentRow[targetColumn];
      let cell_to_append = previousRow[properColumn];

      if (cell_to_change !== null && cell_to_change !== '' && cell_to_change !== undefined) {
         cell_to_append = `${cell_to_append} ${cell_to_change}`;
         data[i-1][properColumn] = cell_to_append;
         data.splice(i, 1);
         i--;
      }
   }
   return data;
}

// this will write the data to a new XLSX file. Should re-write a version of this to simply write the data into a JSON file. 
function export_data (work_book, file_name, options) {
   // makes a new xlsx file, this can be changed easily. Worth adding a case statement here to handle other extensions. 
   let worksheet = XLSX.utils.json_to_sheet(work_book);
   let tempWorksheet = XLSX.utils.sheet_to_json(worksheet, {
      header: 1
   });
   // here we can map to the number key for headers, because doing it during import is the worst.
   tempWorksheet = filter_column_headers(tempWorksheet);
   tempWorksheet = XLSX.utils.json_to_sheet(tempWorksheet);
   console.log(tempWorksheet[0]);
   const new_workbook = XLSX.utils.book_new();
   XLSX.utils.book_append_sheet(new_workbook, tempWorksheet, file_name);
   XLSX.writeFile(new_workbook, "Testing_Book.xlsx", { compression: true });
}


// this is where all the filters are run on the passed in data.  
function import_data (path) {
   const workbook = XLSX.readFile(path);
   const sheet_name = workbook.SheetNames[0];
   let sheet = workbook.Sheets[sheet_name];
   // here we insert a column. Start of creating section names.
   sheet = insert_col(sheet, 0, "");

   const raw_data = XLSX.utils.sheet_to_json(sheet, {
      header: 1,
      blankrows: true
   });
   // these are where the filter functions are applied to the raw data from your target table.
   let filtered_data = raw_data.filter(row => row.some(cell => cell !== null && cell !== '')); // don't import empty rows
   filtered_data = contract_filter(filtered_data); // remove the page labels from the contract
   filtered_data = filter_below_match_flex(filtered_data, ["SUBTOTAL", "SUBTOTAL:"]); // remove the legal jargon at the bottom of a contract
   filtered_data = filter_above_match(filtered_data, "SIGNAGE PROGRAM:"); // remove the headers, could use this data later.
   filtered_data = filter_extra_descriptions(filtered_data, 3); // merge cells where rows were made to complete a sentence (lol)
   filtered_data = filter_section_column(filtered_data, 1, 0);
   // filtered_data = filter_add_column_headers(filtered_data);
   filtered_data = remove_last_subtotal(filtered_data);
   filtered_data = filter_data_in_wrong_colum(filtered_data, 5, 3);  // filters description details that are getting put into the wrong place
   return filtered_data;
}

function process_xlsx(path, destination) {
   const path_regex = //;
   const data = import_data(path);
   let file_name = path.replace(path_regex);
   export_data(file, file_name);
}

function batch_contract_clean(directory, destination) {
  
}

const file = "./00-contract_samples/2206JPI02S Anna Waters Creek REV 3 Signage.xlsx";
const file2 = "./00-contract_samples/2108EP03S Bel Aire Revision 2- Corrected Math.xlsx";
const data = import_data(file2);
export_data(data);
console.log(data[0]);

