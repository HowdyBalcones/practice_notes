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
// > Metadata into cols 
//    + create metadata object -- done
//    + need to write the function to add the columns according to the object keys. -- done
//    + write something that appends each processed file into a single text doc -- done
//    + need to create a col for the file name -- done
//    + signage program name needs a col -- done, found bugs and fixed 
// > all the added data columns makes it important to be able to export only specific columns. 
//    + an export function that will only target specific columns - 
//
// > write a set of functions to test the cleaned contracts for errors. 
//    + test exact columns required
//    + test for no gaps in rows -- priority
//    + does the section col exist? Are there any gaps in the section col? 
//    + also pretest the raw contract against a template to determine form type -- this seems promising
//       - test rows for section keywords -- we did this in a few ways, removing subtotals and other lines
//       - test for page layout view -- refer to the WBProps key of the workbook object
//       - the best one is gonna be testing for a metadata section. if there is none then don't process the document. 
//       - next best is testing if the section names start with the usual section numbers, rather than arbitrary strings
//    + types of forms - 
//       - main signage contract - the form we've been working with, meant for sign designers -- priority, if we have this the other things can be filtered
//       This is done, we can test a file to see if it's the main signage contract. It filters out the other forms and doesn't export them unless they 
//       match the sign form conditions. 
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
   const fource_headers = ["SECTION_ID", "SPOTTING_KEY", "SIGN_COUNT", "SIGN_DESCRIPTION", "EACH_COST", "TOTAL_COST", "CLIENT", "CONTACT", "CONTRACT_NUMBER", "REVISIONS", "PROJECT_NAME", "CONTRACT_FILE"];
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
         case "10":
            headerRow[i] = fource_headers[6];
            break;
         case "11":
            headerRow[i] = fource_headers[7];
            break;
         case "12":
            headerRow[i] = fource_headers[8];
            break;
         case "13":
            headerRow[i] = fource_headers[9];
            break;
         case "14":
            headerRow[i] = fource_headers[10];
            break;
         case "15":
            headerRow[i] = fource_headers[11];
            break;
         default:
            break;
      }
   }
   return data;
}

function remove_kw_bottom_up (data, keyword) {
   const test_row = (element) => {
      return typeof element === 'string' && element.includes(keyword);
   }
   for (let i = data.length - 1; i >= 0; --i) {
      let row = data[i];
      if (row.some(test_row)) {
         data.splice(i, 1);
      }
   };
   return data;
}

function remove_last_subtotal(data) {
   // data.pop();
   data.shift();
   return data;
}

// this checks where the section col is in the raw form, filters the text there, then creates a col at the start of the doc
// then appends the section name that was last filtered until it encounters the next section. 
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

// goal is to create columns filled with the value at each key of the passed in object
// data should be 2d array of contract data
function fill_col_object_val(data, object) {
   let cols_to_add = Object.keys(object);
   for (let i = 0; i < cols_to_add.length; ++i) {
      let object_value = object[`${cols_to_add[i]}`];
      data.forEach((row) => {
         row.push(object_value);
      }); 
   }
   return data;
}

// takes a literal file name and adds it to the last col at time of invocation
function fill_col_src_file(data, file_name) {
   for (let i = 0; i < data.length; ++i) {
      let row = data[i];
      row.push(file_name);
   }
   return data;
}

// in out raw form people have been trained to add new lines to a cell below their line item. 
// function appends these extra lines to a single line in the description, the actual line item field. 
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
   const filtered_data = match_index !== -1 ? data.slice(0, match_index + 1) : new Error("Couldn't filter below");
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
   const filtered_data = match_index !== -1 ? data.slice(0, match_index + 1) : new Error("Couldn't filter below");
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
   const filtered_data = match_index !== -1 ? data.slice(0, match_index + 1) : new Error("Couldn't filter below");
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

// might work better as a key value map, where the first map is a key and the subsequent string is the value until the next key. 
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
      try {
         let item = metadata[i];
         let isKeyword = kw.some(keyword => item.includes(keyword));
      } catch(e) {
         
      }

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

// cells that contain company logo and such, deleted here
function contract_filter (data) {
   // filter first column, only return rows that don't contain the given string
   return data.filter(row => row[1] !== "FOURCE COMMUNICATIONS");
}

// this reworks the former metadata function, returns an object that takes headers as keys and their data as values 
function filter_for_metadata_obj(data) {
   const metadata = [];
   let data_obj = {};
   const raw_meta_data = filter_below_match(data, "SIGNAGE PROGRAM:");
   const kw = ['CLIENT:', 'ATTN:', 'QUOTE #:', 'DATE:', 'SIGNAGE PROGRAM:'];
   let found_keyword = false;
   let current_key = '';
   let data_string = '';
   // console.log("raw metadata arr", raw_meta_data);
   // this flattens the data to a 1 dimensional array and removes empty cells 
   if (!raw_meta_data) {
      return;
   }
   for (let i = 0; i < raw_meta_data.length; ++i) {
      let row = raw_meta_data[i];
      row.forEach((cell) => {
         if (cell) metadata.push(cell);
      });
   }
   // console.log("metadata arr", metadata);
   // the loop below pulls the metadata into a key/value map using the kw array to set the keys
   for (let i = 0; i <= metadata.length; ++i) {
      //console.log(current_key, data_string);
      let item = `${metadata[i]}`;
      if (!item) {
         return "";
      }
      // this checks the index value against an array of keywords, if the value at the index contains the keyword init isKey to true;
      let is_key = kw.some(keyword => item.includes(keyword));
      if (is_key || i === metadata.length) {
         if (current_key && data_string) {
            data_obj[current_key] = data_string.trim();
         }
         current_key = item.replace(':', '').trim();
         data_string = '';
      } else {
         data_string += `${item} `;
      }
   }
   // console.log(data_obj)
   return data_obj;
}

// this is going to be a rudimentary way to start searching through the data.
// there's a lot that could be done in it's place, but we wanna get rolling. 
function flatten_and_write_txt(data) {
   let flattened_data = '';
   for (let i = 0; i < data.length; ++i) {
      let row = data[i];
      let line_of_text = row.join("\t"); 
      flattened_data += `${line_of_text}\n`;
   }
   return flattened_data;
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

function test_page_layout(workbook, sheet_name) {
   const worksheet = workbook.Sheets[sheet_name];
   const directory = workbook.Directory;
   const views = workbook.WBProps;
   console.log(views, workbook.Workbook);
   if (worksheet && worksheet.pageLayout) {
      console.log("pg layout yes");
   } else {
      console.log("pg layout no");
   }
}

function test_section_col(data) {
   for (let i = 0; i < data.length; ++i) {
      let row = data[i];
      if (!row[0]) {
         return null;
      }
   }
}

// this aligns headers and writes the file. It takes a 2D array as input. 
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
function import_data (path, file_name) {
   const workbook = XLSX.readFile(path);
   const sheet_name = workbook.SheetNames[0];
   // test_page_layout(workbook, sheet_name);
   let sheet = workbook.Sheets[sheet_name];
   // here we insert a column. Start of creating section names.
   sheet = insert_col(sheet, 0, "");

   const raw_data = XLSX.utils.sheet_to_json(sheet, {
      header: 1,
      blankrows: true
   });
   // these are where the filter functions are applied to the raw data from your target table.
   let filtered_data = raw_data.filter(row => row.some(cell => cell !== null && cell !== '')); // don't import empty rows
   let filtered_metadata = filter_for_metadata_obj(filtered_data);
   if (Object.keys(filtered_metadata).length === 0) {
      console.log(`Not processed, metadata not found: ${file_name}`);
      return;
   }
   try {
      filtered_data = contract_filter(filtered_data); // remove the page labels from the contract
      filtered_data = filter_below_match_flex(filtered_data, ["SUBTOTAL", "SUBTOTAL:"]); // remove the legal jargon at the bottom of a contract
      filtered_data = filter_above_match(filtered_data, "SIGNAGE PROGRAM:"); // remove the headers, could use this data later.
      filtered_data = filter_extra_descriptions(filtered_data, 3); // merge cells where rows were made to complete a sentence (lol)
      filtered_data = filter_section_column(filtered_data, 1, 0);
      // filtered_data = filter_add_column_headers(filtered_data);
      filtered_data = remove_last_subtotal(filtered_data);
      filtered_data = filter_data_in_wrong_column(filtered_data, 5, 3);  // filters description details that are getting put into the wrong place
      filtered_data = fill_col_object_val(filtered_data, filtered_metadata);
      filtered_data = fill_col_src_file(filtered_data, file_name);
      filtered_data = remove_kw_bottom_up(filtered_data, "SUBTOTAL");
      // console.log(filtered_data);
      const testing_section = test_section_col(filtered_data);
      if (testing_section === null) {
         console.log(`Not processed, section column missing data: ${file_name}`);
         return;
      }
      return filtered_data;
   } catch(e) {
      console.log(`Import Error: ${e}, ${file_name}`);
   }
}

// this was an attempt to re-arrange the file names into something more useable. It just causes problems. 
// there is utility in creating new file names for the cleaned contracts but it's low priority. Fun regex though. 
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

// this is the cli utility function. Lets you run the script with arguments, which should be a destination followed by a list of files for input. 
function batch_contract_clean() {
   // order of args: node, script, destination, files...
   // this slice means we ignore the first three in the argv array. 
   const file_paths = process.argv.slice(3);  
   const destination_path = process.argv[2];
   console.log(destination_path)
   if (file_paths.length === 0) {
      console.error('No files provided. Usage: node script.js file1 file2 etc...');
      process.exit(1);
   }
   function create_txt_archive(data) {
      let flat_data = flatten_and_write_txt(data);
      const archive_path = path.join(destination_path, "testing_archive.txt");
      fs.appendFile(archive_path, flat_data, (e) =>{
         if (e) {
            console.error('Error appending to file.', e);
         } else {
            console.log('Data appended to archive');
         }
      })
   }
   function process_file(file_path) {
      try {
         const full_path = path.resolve(file_path);
         const file_name = path.basename(file_path);
         if (!fs.existsSync(full_path)) {
            console.error(`File not found: ${file_path}`);
            return;
         }
         const clean_contract = import_data(full_path, file_name);
         if (!clean_contract) {
            return;
         }
         const new_file_path = path.join(destination_path, file_name);
         export_data(clean_contract, new_file_path);
         // create_txt_archive(clean_contract);
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

module.exports = { insert_col, filter_column_headers, remove_kw_bottom_up, filter_section_column, filter_extra_descriptions, filter_below_match, filter_below_match_flex, filter_above_match, contract_filter, filter_data_in_wrong_column, export_data, import_data, normalize_contract_names, batch_contract_clean };

