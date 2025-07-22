const XLSX = require('xlsx');
const Database = require('better-sqlite3');
const path = require('path');
const fs = require('fs');

// notes on better-sqlite3
// - make new Database(name, {opts})
// - prepare prepares a statement to run on a database. As: const stmt = db.prepare('SELECT name, age FROM cats');
// - ?s are arg parameters, they separate code from data. 
// - table names need to be quoted if they contain spaces, special characters, start with a number, etc

function make_db(db_name = "") {
   if (!db_name) {
      console.log("no name");
   }
   if (db_name.endsWith(".db")) {
      const prefix_idx = db_name.lastIndexOf(".db");
      db_name = db_name.slice(0, prefix_idx);
   } 
   // const db = new Database(`${db_name}.db`, { verbose: console.log });
   const db = new Database(`${db_name}.db`);
   return db;
}

function get_table_name(json) {
   const table_name = `'${json[1]["8"]}-${json[1]["10"]}'`
   return table_name;
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
   // enforce types on named fields
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

   const json_map = {
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

function check_table_exists(db, table_name) {
   const check_stmt = db.prepare(`
         SELECT name FROM sqlite_master
         WHERE type='table' AND name=${table_name}
      `);
   const exists = check_stmt.get() !== undefined;
   return exists;
}

function create_contract_table(name="err") {
   const json_map = make_field_map();
   const field_map = json_map.field_map;
   const type_map = json_map.type_map;

   // make the table
   const columns = Object.entries(field_map).map(
      ([json_key, column]) => `${column} ${type_map[column]}`)
      .join(", ");

   const create_table_sql = `
   CREATE TABLE ${name} (
   id INTEGER PRIMARY KEY AUTOINCREMENT,
   ${columns}
   )
   `
   return create_table_sql;
}

function insert_json_to_table(json, db, table) {
   const { field_map, type_map } = make_field_map();
   const columns = Object.values(field_map);
   //console.log(json)

   // idk what the ?s are for yet
   const insert_statement = db.prepare(`
         INSERT INTO ${table} (${columns.join(', ')})
         VALUES (${columns.map(() => '?').join(', ')})
      `);

   db.transaction(() => {
      for (let i = 1; i < json.length; ++i) {
        try {
           let row = json[i];
           const row_values = Object.keys(field_map).map(key => row[key] ?? null);
           insert_statement.run(row_values);
        } catch(row_error) {
           console.error(`Failed row: ${JSON.stringify(row_value)}`, row_error);
           throw row_error;
        }
      }
   })();
   //console.log(db)
}

function json_to_db(path, db_name) {
   const json_contract = xlsx_to_json(path);
   const db = make_db(db_name);

   const table = create_table();
   console.log(table);
   db.exec(table);

   console.log(db);
}

function q_table(db, statement) {
   const rows = db.prepare(`${statement}`).all();
   return rows;
}

function test_db(db, table_name) {
   const rows = db.prepare(`SELECT * FROM ${table_name}`).all();
   console.log(rows);
}

function test_db_tables(db, table_name) {
   const rows = db.prepare(`
      SELECT name FROM sqlite_master
      WHERE type='table' AND name LIKE '%${table_name}%'
      `).all();
   console.log(rows);
}

function batch_files() {
   const file_paths = process.argv.slice(3);
   const destination_path = process.argv[2];
   if (file_paths === 0) {
      console.error('No files provided: Usage node script destination files...');
      process.exit(1);
   }
   
   function make_folder(folder_name) {
      const folder_path = path.join(destination_path, `/${folder_name}`);
      
      try {
         fs.mkdir(folder_path, {recursive: true}, (err) => {
            if (err) {
               throw new Error(err)
            }
         });
      } catch(folder_error) {
         if (folder_error === 'EEXISTS') {
            console.error(`Folder exists ${folder_error}`);
         } else {
            console.error(`Error making folder: ${folder_error.module} - ${folder_error.code} - ${folder_error.message}`);
         }
      }
   }

   function write_sql_data(data, file_path, table_name) {
      // this will take each contract, make a table for that contract name, then write the contract to a db
      const db_name = "FRC-MAIN";
      const db_path = path.join(destination_path, `/${db_name}.db`);
      const main_db = make_db(db_path);

      if (!check_table_exists(main_db, table_name)) {
         main_db.exec(create_contract_table(table_name));
      }

      insert_json_to_table(data, main_db, table_name);
      test_db(main_db, table_name);
      
      // console.log(check_table_exists(main_db, table_name));
   }

   function process_file(file_path) {
      console.log(file_path);
      let file_name = 'unknown';
      try {
         const full_path = path.resolve(file_path);
         console.log(full_path);
         if (!full_path) {
            console.log(`Error resolving file_path: ${file_path}`);
            return;
         }
         file_name = path.basename(full_path);
         if (!file_name) {
            console.log(`Cannot resolve file_name: ${full_path}`);
         }
            try {
               // console.log(file_path);
               const target_data = xlsx_to_json(full_path);
               const table_name = get_table_name(target_data);
               write_sql_data(target_data, full_path, table_name);
            } catch(write_error) {
               console.error(`Error writing file: ${write_error.module} - ${write_error.code} - ${write_error.message}`);
            }
         
      } catch(file_error) {
         console.log(`Error processing file: ${file_error}, file name: ${file_name}`);
      }
   }

   file_paths.forEach((path) => process_file(path));
}

function main() {
   const test_path = "./02-results/previous_tests/2106G14RS Broadstone Trinity REV 3.xlsx"
   const proto_db = make_db("FRC-MAIN");
   try {
      // make_db("frc_working.db");
      // xlsx_to_sql(test_path);
      // json_to_db(test_path, "frc_working");
      // const test = make_field_map()
      // create_table();
      // console.log(test);
      // json_to_db(test_path, "frc_working");
      // insert_json_to_table(xlsx_to_json(test_path), make_db("frc_working"));
      // test_db(make_db(proto_db), "");
      // batch_files();
      test_db_tables(proto_db, 'G');
   } catch(e) {
      console.log(`Error in database module: ${e}`)
   }
}
main()
