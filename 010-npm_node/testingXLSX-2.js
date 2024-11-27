const XLSX = require('xlsx');

const file = "./2211AM01S Fairmount Signage REV 1.xlsx";

const CSV_options_00 = {
   
}

// left off here.
function filter_section_column (data) {
   const filtered_data; 
}

function filter_below_match (data, term_match) {
   // find the row with the matching term, delete everything underneath that row.
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

function contract_filter (data) {
   // filter first column, only return rows that don't containt the given string
   return data.filter(row => row[0] !== "FOURCE COMMUNICATIONS");
}

function export_data (work_book, options) {
   // makes a new xlsx file, this can be changed easily. Worth adding a case statement here to handle other extensions. 
   const worksheet = XLSX.utils.json_to_sheet(work_book);
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
   const sheet = workbook.Sheets[sheet_name];

   const raw_data = XLSX.utils.sheet_to_json(sheet, {
      header: 1,
      blankrows: false
   });
   // these are where the filter functions are applied to the raw data from your target table. 
   let filtered_data = raw_data.filter(row => row.some(cell => cell !== null && cell !== '')); // don't import empty rows
   filtered_data = contract_filter(filtered_data); // remove the page labels from the contract
   filtered_data = filter_below_match(filtered_data, "SUBTOTAL"); // remove the legal jargon at the bottom of a contract
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
export_data(data);
console.log(data);
