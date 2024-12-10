const XLSX = require('xlsx');

const file = "./2211AM01S Fairmount Signage REV 1.xlsx";

// reference
// https://docs.sheetjs.com/docs/csf/sheet/
// https://docs.sheetjs.com/docs/csf/general/

// important notes
// we are working with 2D arrays rather than worksheet objects, so the built in methods for 
// sheetJS won't work on the data we are passing between functions.

// Left off markers
// 10-12-2024 - left off trying to format our headers. We are using sheet_to_json to create an AoA. 

const CSV_options_00 = {
   
}

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

function insert_col2(data, columnIndex, columnData) {
   // this works on 2D arrays not sheet objects
   for (let i = 0; i < data.length; ++i) {
      let row = data[i];
      row.splice(columnIndex, 0, columnData);
   }
   return data;
}

// left off here.
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

function export_data (work_book, options) {
   // makes a new xlsx file, this can be changed easily. Worth adding a case statement here to handle other extensions. 
   const worksheet = XLSX.utils.json_to_sheet(work_book, {
      header: ["Section", "Count", "ETC"]
   });
   const new_workbook = XLSX.utils.book_new();
   XLSX.utils.book_append_sheet(new_workbook, worksheet, "Testing-00");
   XLSX.writeFile(new_workbook, "Testing_Book.xlsx", { compression: true });

   // XLSX.write(wb, opts) -- attempts to write the workbook and return the file
   // XLSX.writeFile(wb, filename, opts) -- attempts to write wb to a local filename
   // const prez = raw_data.filter(row => row.terms.some(term => term.type === "prez")); <-- consider
}


function import_data (path) {
   // this is what brings in data from a target table. Generic, so file extension is slightly flexible. 
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
   filtered_data = filter_below_match(filtered_data, "SUBTOTAL"); // remove the legal jargon at the bottom of a contract
   filtered_data = filter_above_match(filtered_data, "SIGNAGE PROGRAM:"); // remove the headers, could use this data later.
   filtered_data = filter_extra_descriptions(filtered_data, 3); // merge cells where rows were made to complete a sentence (lol)
   filtered_data = filter_section_column(filtered_data, 1, 0);
   return filtered_data; 
}



function extractData(filePath) {
   // this was a test at the very start it doesn't get used currently. 
   const workbook = XLSX.read(file);
   const sheetNames = workbook.SheetNames;
   
   const sheet = workbook.Sheets[sheetNames[0]];
   
   let data = XLSX.utils.sheet_to_json(sheet, { header: 1 });
   return sheet;
}

const data = import_data(file);
//insert_col(data, 0, "TESTING");
export_data(data);
console.log(data);
