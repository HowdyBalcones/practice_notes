const XLSX = require('xlsx');
const fs = require('fs');
const path = require('path');
// const { export_data } = require("./contract_db_import.js");

// TODO
// > export function that doesn't add needless numbered headers to the file
//    + important to remember, we are dealing with arrays of objects when bringing in a clean contract. 
// > pick up working on the new export function. There are some problems we didn't forsee. 
//    + issue with header numbers
//    + issue parsing sparse rows, our check isn't working or the removal, can't tell
//    + when we write a new file after removing the sparse rows, we need to remove any 
//    extra headers that may have been added. 



function write_to_log(data, error_row_arr, file_name) {
   let txt_string = '';
   for (let i = 0; i < error_row_arr.length; ++i) {
      let idx = error_row_arr[i];
      txt_string += `${file_name}: Error at row ${idx}: ${data[idx].join(",")}\n`;
   }
   return txt_string; 
}

// this will loop explicitly over the row and check each element. Can't use array methods 
// because they don't handle sparse arrays very well. 
// the issue with this was that the data is an AoO, not AoA
function test_complete_row(data) {
   let empty_arr = [];
   let element_arr = [];
   for (let i = 0; i < data.length; ++i) {
      let row = data[i];
      let has_empty = false;
      for (let j = 0; j < row.length; ++j) {
         let element = row[j];
         if (element === undefined || element === null || element === '') {
            has_empty = true;
            // element_arr.push(typeof element);
         }
      }
      if (has_empty) {
          // empty_arr.push(i);
         console.log(row);
         data = data.splice(i, 1);
      }
   }
   return data; 
}

function check_sparse(row) {
   console.log(row.length);
   for (let j = 0; j < row.length; ++j) {
      let element = row[j];
      if (element === undefined || element === null || element === '') {
         return true;
      } 
   }
   return false;
}

function show_row(data) {
   let i = 0;
   while (i < data.length) {
      let row = data[i];
      const nullish = (element) => element === null || element === undefined || element === '';
      // if (row) console.log(typeof row);
      // if (Object.entries(row).length > 12 || Object.entries(row).length < 12) console.log(`Row: ${i} Length: ${Object.entries(row).length}`)

      console.log(`Row: ${i} Nullish: ${Object.entries(row).some(nullish)}`);
      ++i;
   }
   console.log(data[195]);
}

// this removes long rows, usually rows where desc information is getting appended incorrectly. It will take the extra cells off the header. 
function remove_long_rows_while(data, file) {
   let i = 0;
   while (i < data.length) {
      let row = data[i];
      let row_len = Object.entries(row).length;
      if (row_len > 12 || row_len < 12 && i === 0) {                 // remove extra cells from header if data has extra row
         let row_key_arr = Object.keys(row);
         for (let j = 0; j < row_key_arr.length; ++j) {
            if (row_key_arr[j] > 11) delete row[row_key_arr[j]];
         }
         ++i;
      } else if (row_len > 12 || row_len < 12) {                     // then remove the extra row from the body of the data
         data.splice(i, 1);
         console.log(`Removed row: ${i} From file: ${file}`);
      } else {                                                       // then increment
         ++i;
      }
   }
   return data;
}

// repurpose, use with the remove_long_rows_while function
function create_append_log(data, file_name) {
   let error_arr = test_complete_row(data);
   console.log(error_arr);
   console.log(file_name, data);
   let error_msg = error_arr !== 0 ? write_to_log(data, error_arr, file_name) : 0;
   if (error_msg !== 0) {
       fs.appendFile(archive_path, error_row, (e) => {
          if (e) {
             console.error('Error appending to log file.', e);
          } else if (error_row) {
             console.log('Row missing data, file and row logged.');
          }
       })      
   } else {
      return;
   }
}



// this will be where the tests are applied to the exported files.
function import_clean_contract(path, file_name) {
   const workbook = XLSX.readFile(path);
   const sheet_name = workbook.SheetNames[0];
   let sheet = workbook.Sheets[sheet_name];
   const raw_data = XLSX.utils.sheet_to_json(sheet, {
      blankrows: true
   });
   let filtered_data = raw_data;
   // filtered_data = test_complete_row(filtered_data);
   try {
      // filtered_data = remove_sparse_while(filtered_data, check_sparse());
      // show_row(filtered_data);
      filtered_data = remove_long_rows_while(filtered_data, file_name);
   } catch(e) {
      console.log(`Import Error: ${e}`);
   }
   return filtered_data;
}

function export_data(workbook, file_path) {
   const new_workbook = XLSX.utils.book_new();
   let worksheet = XLSX.utils.json_to_sheet(workbook);
   XLSX.utils.book_append_sheet(new_workbook, worksheet, "Sheet 1");
   XLSX.writeFile(new_workbook, file_path, { compression: true });
}

function test(path, file_name) {
   console.log(path, file_name);
}

function json_file_name(data) {
   let row = data[2];
   let job_num = row["8"];
   let job_name = row["10"];
   let file_name = `json_data/${job_num}--${job_name}.json`; 
   return file_name;
}

// this will be the function for cli interface 
function batch_test_clean_contracts() {
   const file_paths = process.argv.slice(3);
   const destination_path = process.argv[2];
   const log_path = path.join(destination_path, "000-log.txt");
   if (file_paths.length === 0) {
      console.error('No files provided: Usage node script destination files...');
      process.exit(1);
   }

   function write_json_lib(data, file_path) {
      const full_path = path.resolve(file_path);
      try {
         const new_data = JSON.stringify(data);
         const json_name = json_file_name(data);
         const file_name = path.basename(full_path);
         const new_path = path.join(destination_path, json_name);
         fs.writeFile(new_path, new_data, (error) => {
            if (error) {
               console.error('Error writing json file:', error);
            } else {
               console.log('Json file written successfully.');
            }
         });
      } catch(e) {
         console.log(`Failure to write json file: ${e}`);
      }
   }

   function process_file(file_path) {
      const full_path = path.resolve(file_path);
      try {
         const file_name = path.basename(file_path);
         const new_file_path = path.join(destination_path, file_name);
         if (!fs.existsSync(full_path)) {
            console.error(`File not found: ${file_path}`);
            return;
         }
         const target_data = import_clean_contract(full_path, file_name);
         write_json_lib(target_data, full_path);
         export_data(target_data, new_file_path);
         console.log(`Processed clean contract, saved to: ${new_file_path}`)
         // console.log(target_data);
         // console.log(test_complete_row(target_data))
      } catch(e) {
         console.log(`Process Error: ${e}, ${full_path}`)
      }
   }
   file_paths.forEach((path) => process_file(path));
}

batch_test_clean_contracts();
