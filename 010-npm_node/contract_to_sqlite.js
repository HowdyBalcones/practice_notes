const XLSX = require('xlsx');
const Database = require('better-sqlite3');
const fs = require('fs');

function make_db(db_name = "") {
   if (!db_name) {
      console.log("no name");
   }
   if (db_name.endsWith(".db")) {
      const prefix_idx = db_name.lastIndexOf(".db");
      db_name = db_name.slice(0, prefix_idx);
   } 
   const db = new Database(`${db_name}.db`, { verbose: console.log });
   return db;
   //console.log(`${db_name}.db created`)
}

function make_field_map() {
   // this is for mapping the json to specific sql fields
   const field_map = {
      "0": "Section",
      "1": "Key",
      "2": "Sign_Count",
      "3": "Sign_Description",
      "4": "Each_Cost",
      "5": "Total_Cost",
      "6": "Client_Address",
      "7": "Point_of_Contact",
      "8": "Contract_ID",
      "9": "Revision_Dates",
      "10": "Client_Name",
      "11": "Contract_File_Name"
   }

   const type_map = {
      "Section": "TEXT",
      "Key": "TEXT",
      "Sign_Count": "INTEGER",
      "Sign_Description": "TEXT",
      "Each_Cost": "REAL",
      "Total_Cost": "REAL",
      "Client_Address": "TEXT",
      "Point_of_Contact": "TEXT",
      "Contract_ID": "TEXT",
      "Revision_Dates": "TEXT",
      "Client_Name": "TEXT",
      "Contract_File_Name": "TEXT"
   }

   const json_map {
      "field_map": field_map,
      "type_map": type_map,
   }
   return json_map;
}

function xlsx_to_json(path) {
   const workbook = XLSX.readFile(path);
   const sheet_name = workbook.SheetNames[0];
   let sheet = workbook.Sheets[sheet_name];
   const sheet_json = XLSX.utils.sheet_to_json(sheet, {
      blankrows: true
   });
   return sheet_json;
   //console.log(sheet_json);
}

function json_to_db(path, db_name) {
   const json_contract = xlsx_to_json(path);
   const db = make_db(db_name);

   const cols = Object.keys(json_contract[0]);

   console.log(cols);
}


function main() {
   const test_path = "./02-results/previous_tests/2106G14RS Broadstone Trinity REV 3.xlsx"
   try {
      // make_db("frc_working.db");
      // xlsx_to_sql(test_path);
      // json_to_db(test_path, "frc_working");
      const test = make_field_map()
   } catch(e) {
      console.log(`Error in database module: ${e}`)
   }
}
main()
