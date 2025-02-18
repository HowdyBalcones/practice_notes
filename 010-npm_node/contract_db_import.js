// the goal of this program is to rewrite the contract filter program to handle many files at once and store them in a coherent manner. 
// the next goal is to be able to write these files into a postgres database. 
// then I want a simple cli interface for adding new contracts to the database.
// 
// WINS
// > the basic filter for new contracts is done, there are kinks but it does most of the work it needs to.
// > the function to call the script from the cli is done, it works great and is fast. 
// > bash script to find files and pull them from the server in a coherent way is done. 
// > 
//
// TODO 
// > Metadata into cols is priority. With that created, we can dump the clean contracts into a sql db and start running fast
// The tests are important, but also idgaf about the other form types. I don't work in those departments. 
// > write a set of functions to test the cleaned contracts for errors. 
//    + test exact columns required
//    + test for no empty rows 
//    + how to test for different forms? because there are standards, but they aren't explicit
//    + it would be nice if we could check the total number of line items from the original to the clean copy, that will take some brainblasting
//    + does the section col exist? Are there any gaps in the section col? 
//    + also pretest the raw contract against a template to determine form type -- this seems promising
//       - test headers and footers against template
//       - test rows for section keywords
//       - 
//    + types of forms - 
//       - main signage contract - the form we've been working with, meant for sign designers
//       - addon tracking form - created after a book is complete, reconciles altered qtys 
//       - website contract - used for billing a website design job 
//       - misc contract - small jobs, usually under ten signs. they are extremely random in layout. 
//       - temp sign contracts - for temporary signage, similar to website contract
//       - 



const XLSX = require('xlsx');
const fs = require('fs');
const path = require('path');

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
   const inued_regex = /INUED/;
   for (let i = 0; i < data.length; ++i) {
      let row = data[i];
      let sectionCell = row[sectionColumn];
      if (sectionCell && sectionRegex.test(sectionCell)) {
         currentSection = sectionCell.replace(cellRegex, "");
         currentSection = currentSection.replace(cellPageRegex, "");
         currentSection = currentSection.replace(inued_regex, "");
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

function filter_for_metadata(data) {
   const metadata = [];
   const composed_metadata = [];
   let data_string = '';
   let found_keyword = false;
   const kw = ['CLIENT:', 'ATTN:', 'QUOTE #:', 'DATE:', 'SIGNAGE PROGRAM:'];
   const raw_meta_data = filter_below_match_flex(data, "SIGNAGE PROGRAM:");
   for (let i = 0; i < raw_meta_data.length; ++i) {
      let row = raw_meta_data[i];
      row.forEach((cell) => {
         if (cell) metadata.push(cell);
      })
   }
   // this checks for keyword matches and appends the match and each item until the next match, pushing the string onto the composed_metadata array 
   // upon finding the next match. lets fine tune this over the coming days. 
   for (let i = 0; i < metadata.length; ++i) {
      let item = metadata[i];
      let isKeyword = kw.some(keyword => item.includes(keyword));

      if (isKeyword) {
         if (found_keyword && data_string.length > 0) {
            composed_metadata.push(data_string);
            data_string = '';
         }
         found_keyword = true;
      }
      if (found_keyword) {
         data_string += `${item} `;
      }
   }
   if (data_string.length > 0) {
      composed_metadata.push(data_string);
   }
   console.log(composed_metadata);
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
function filter_data_in_wrong_column(data, targetColumn, properColumn) {
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

function export_data (work_book, file_path) {
   // json data to sheet object
   let worksheet = XLSX.utils.json_to_sheet(work_book);
   // and then back to json
   let tempWorksheet = XLSX.utils.sheet_to_json(worksheet, {
      header: 1
   });
   // align the headers correctly
   tempWorksheet = filter_column_headers(tempWorksheet);
   // and then back to sheet!?
   tempWorksheet = XLSX.utils.json_to_sheet(tempWorksheet);

   // make the workbook name, the sheet, add the sheet to the book, add name in the write method
   // const new_workbook_name = normalize_contract_names(file_path); 

   const new_workbook = XLSX.utils.book_new();
   XLSX.utils.book_append_sheet(new_workbook, tempWorksheet, "Sheet 1");
   XLSX.writeFile(new_workbook, file_path, { compression: true });
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
   filter_for_metadata(filtered_data);
   filtered_data = filter_above_match(filtered_data, "SIGNAGE PROGRAM:"); // remove the headers, could use this data later.
   filtered_data = filter_extra_descriptions(filtered_data, 3); // merge cells where rows were made to complete a sentence (lol)
   filtered_data = filter_section_column(filtered_data, 1, 0);
   // filtered_data = filter_add_column_headers(filtered_data);
   filtered_data = remove_last_subtotal(filtered_data);
   filtered_data = filter_data_in_wrong_column(filtered_data, 5, 3);  // filters description details that are getting put into the wrong place
   return filtered_data;
}

function normalize_contract_names(path_name) {
   const path_name_regex = /^(\/|\.|\.\.).*/;
   const spaces_regex = /\s+/g;
   const file_name_regex = /[A-Za-z0-9\s\.]+\.xlsx$/;
   const job_identifier_regex = /^[A-Za-z0-9_\.]+/;
   const job_name_regex = /^[A-Za-z0-9_\.]+\s+(.*?)\s(Revision|revision|REV|Rev).+\.xlsx$/;
   const revision_num_regex = /\s+(Revision|revision|REV|Rev)\s+?(\d+).*\.xlsx$/;
   const etc_after_revision_regex = /\s+\d+\s([A-Za-z0-9\s]+?)\.xlsx$/;
   const removing_hyphens_regex = /\-+/g;

   if (!path_name.match(path_name_regex)) console.error("Path name regex invalid", `${path_name}`);
   let matched_path_name = path_name.match(path_name_regex);

   matched_path_name = matched_path_name[0].replace(removing_hyphens_regex, '');
   let matched_file_name = matched_path_name.match(file_name_regex);

   if (matched_file_name === null) return "file name didn't match";

   let job_id = matched_file_name[0].match(job_identifier_regex);
   if (job_id === null) return `${matched_file_name[0]}`;

   let job_name = matched_file_name[0].match(job_name_regex);
   if (job_name === null) return `${matched_file_name[0]}`;

   let rev_num = matched_file_name[0].match(revision_num_regex);
   if (rev_num === null) return `${matched_file_name[0]}`;

   let etc_after_rev = matched_file_name[0].match(etc_after_revision_regex);
   if (etc_after_rev === null) return `${matched_file_name[0]}`;

   let file_name_components = [job_id[0],
                               job_name[1].replace(spaces_regex, "_"),
                               `${rev_num[1].replace(spaces_regex, "_")}_${rev_num[2]}`, 
                               etc_after_rev[1].replace(spaces_regex, "_")
                              ];
   let formatted_file_name = `${file_name_components.join('-')}.xlsx`

   return formatted_file_name;
}

// the goal of this function is to run the cleaning and export xlsx functions on each file passed in as arguments using node builtins
// it should take argv as input, for each file in argv, run the correct functions, it should also take an arg for the destination
function batch_contract_clean() {
   // we are ignoring node, script, destination arg here
   const file_paths = process.argv.slice(3);  
   const destination_path = process.argv[2];
   console.log(destination_path)
   if (file_paths.length === 0) {
      console.error('No files provided. Usage: node script.js file1 file2 etc...');
      process.exit(1);
   }
   function process_file(file_path) {
      try {
         const full_path = path.resolve(file_path);
         const file_name = path.basename(file_path);
         if (!fs.existsSync(full_path)) {
            console.error(`File not found: ${file_path}`);
            return;
         }
         // separated concerns here, let node function handle the path stuff, normalize names just renames a file, let export just do the export
         // const filtered_data = match_index !== -1 ? data.slice(0, match_index + 1) : data;
         const clean_contract = import_data(full_path);
         const new_file_path = path.join(destination_path, file_name);
         export_data(clean_contract, new_file_path);
         console.log(`Processed file saved: ${new_file_path}`)
         
      } catch(e) {
         console.log("Error processing file: ", e);
      }
   }
   file_paths.forEach((path) => process_file(path));
}

batch_contract_clean();

const file = "./00-contract_samples/2206JPI02S Anna Waters Creek REV 3 Signage.xlsx";
const file2 ="./00-contract_samples/2108EP03S Bel Aire Revision 2- Corrected Math.xlsx" 

module.exports = { insert_col, filter_column_headers, remove_last_subtotal, filter_section_column, filter_extra_descriptions, filter_below_match, filter_below_match_flex, filter_above_match, contract_filter, filter_data_in_wrong_column, export_data, import_data, normalize_contract_names, batch_contract_clean };
// const data = import_data(file2);
// export_data(data, file2);
// console.log(data[0]);
