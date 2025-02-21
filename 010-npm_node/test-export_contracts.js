const XLSX = require('xlsx');
const fs = require('fs');
const path = require('path');

// today we learned that some doesn't iterate over empty elements in a sparse array
// most js array methods will not iterate over gaps in the array, so if that's what we're checking for 
// they need to be tested explicitly.

function write_to_log(data, error_row_arr, file_name) {
   let txt_string = '';
   for (let i = 0; i < error_row_arr.length; ++i) {
      let idx = error_row_arr[i];
      txt_string += `${file_name}: Error at row ${idx}: ${data[idx].join(",")}\n`;
   }
   return txt_string; 
}

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
            element_arr.push(typeof element);
         }
      }
      if (has_empty) {
         empty_arr.push(i);
      }
   }
   return [empty_arr, element_arr];
}

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
      header: 1,
      blankrows: true
   });
   return raw_data;
}

function test(path, file_name) {
   console.log(path, file_name);
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


   function process_file(file_path) {
      try {
         const full_path = path.resolve(file_path);
         const file_name = path.basename(file_path);
         if (!fs.existsSync(full_path)) {
            console.error(`File not found: ${full_path}`);
            return;
         }
         const target_data = import_clean_contract(full_path, file_name);
         // console.log(target_data);

         console.log(test_complete_row(target_data))
      } catch(e) {
         console.log(`Process Error: ${e}, ${full_path}`)
      }
   }
   file_paths.forEach((path) => process_file(path));
}

batch_test_clean_contracts();
