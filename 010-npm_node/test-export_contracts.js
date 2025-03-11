const XLSX = require('xlsx');
const fs = require('fs');
const path = require('path');
// const { export_data } = require("./contract_db_import.js");

// NOTES
// > export function that doesn't add needless numbered headers to the file
//    + important to remember, we are dealing with arrays of objects when bringing in a clean contract. 
// TODO
// > we implemented the first version of the write xml library function, need to run tests in the morning. 
//    + writing xml files successfully, can test if they are valid in chrome
//    + left off writing the unique signlist function. Should be something that gets run once and stores the information 
//    when we first go over the data, and doesn't need to repeat. 
// > check the make folder function, it looks sketchy. 
// > figure out validating an xml file. 



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

function separate_revision_rows(data) {
   const revision_regex = /revision[\s]?[\d]+/ig
   const rev_regex = /rev[\s]?[\d]+/ig
   for (i = 0; i < data.length; ++i) {
      let row = data[i];
      let rev_cell = row["9"];
      if (revision_regex.test(rev_cell)) {
         row["9"] = rev_cell.replace(revision_regex, (match) => `${match.trim()}\n`);
      } else if (rev_regex.test(rev_cell)) {
         row["9"] = rev_cell.replace(rev_regex, (match) => `${match.trim()}\n`);
      }
   }
   return data;
}

function filter_contract_num(data) {
   const contract_num_regex = /^[A-Za-z0-9]+ ?/i
   for (i = 0; i < data.length; ++i) {
      let row = data[i];
      let contract_num = row["8"];
      let clean_contract_num = contract_num.match(contract_num_regex);
      row["8"] = clean_contract_num[0];
   }
   return data;
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
      // remove_long_rows needs to happen first in the filtering
      filtered_data = remove_long_rows_while(filtered_data, file_name);
      filtered_data = filter_contract_num(filtered_data);
      filtered_data = separate_revision_rows(filtered_data);
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
   let file_name = `000-json_data/${job_num}--${job_name}.json`; 
   return file_name;
}

function xml_file_name(data) {
   let data_row = data[2];
   let job_num = data_row["8"];
   let job_name = data_row["10"];
   let file_name = `000-xml_data/${job_num}--${job_name}.xml`;
   return file_name;
}

function build_key_obj(row) {
   const section = row["0"].trim();
   const key = row["1"];
   const count = row["2"];
   const description = row["3"];
   const cost = row["4"];
   const total_cost = row["2"] * row["4"];
   const section_key = {"key": key, "section":section};
   let key_obj = {
      "section_list":[section_key],
      "section_key": section_key,
      "section": section,
      "key": key,
      "count": count,
      "description": description,
      "cost": cost,
      "total_cost": total_cost,
      set_total_cost() {
         this.total_cost = this.cost * this.count;
      }
   }
   return key_obj;
}

function build_xml_object(data) {
   const header_row = data[1];
   const data_row = data[2];
   
   const client_name = data_row["6"];
   const contract_num = data_row["8"];
   const project_name = data_row["10"];
   const contract_file = data_row["11"];

   let unique_sections = [];
   let section_map = new Map();
   let xml_object = '';
   let xml_sections = '';
   
   // this is what a row from the contract becomes, only includes essential cells but is flexible what can be included. 
   
   try {
   for (let i = 1; i < data.length; ++i) {
      let row = data[i];
      let section_name = row["0"].trim();
      if (!unique_sections.includes(section_name)) {
         unique_sections.push(section_name);
      } 
      if (!section_map.has(section_name)) {
         section_map.set(section_name, []);
      }
      section_map.get(section_name).push(build_key_obj(row));
   }
   
   // here we destructure the map object (contract body content) and serialize the data into xml
   const section_map_array = Array.from(section_map);
   for (let j = 0; j < section_map_array.length; ++j) {
      let section_arr = section_map_array[j];            // is array
      let section_name = section_arr[0].trim();          // is string
      let section_row_arr = section_arr[1];              // is sub-array
      let values_object = section_row_arr[0];            // is object
      xml_sections += serialize_sections(escapeXML(section_name), section_row_arr); 
   }

    const unique_signs_xml = `
      ${serialize_unique_signs(unique_signs(data))}
    `
   // metadata section serialized here 
   const metadata = `
   <contract_num>${escapeXML(contract_num)}</contract_num>
   <contract_file>${escapeXML(contract_file)}</contract_file>
   <client_name>${escapeXML(client_name)}</client_name>
   <project_name>${escapeXML(project_name)}</project_name>
   <project_address></project_address>
   <designer_name></designer_name>
   `
  // content inside root is arranged here    
   xml_object = `
      <job_info>
      <contract>
      <contract_name>${escapeXML(contract_file)}</contract_name>
      ${xml_sections}
      </contract>
      <metadata>
      ${metadata}
      </metadata>
      <unique_sign_list>
      ${unique_signs_xml}
      </unique_sign_list>
      </job_info>
      `
      
   } catch(err) {
      console.log(`Error serializing XML: ${err}`);
   }
   return xml_object;
}

let unique_signs = (data) => {
   let unique_sign_list = [];
   
   for (i = 1; i < data.length; ++i) {
      let row = data[i];
      const new_obj = build_key_obj(row);
      unique_sign_list = find_same_obj(unique_sign_list, new_obj);
   }
   return unique_sign_list;
}

let find_same_obj = (arr, new_obj) => {
   const existing_obj = arr.find(obj => obj.description === new_obj.description);
   if (existing_obj) {
      existing_obj.count += new_obj.count || 1;
      existing_obj.set_total_cost();
      existing_obj.section_list.push(new_obj.section_list[0]);
   } else {
      arr.push({...new_obj, count: new_obj.count || 1});
   }
   return arr;
}
let escapeXML = (str) => {
   if (!str) return "";
   return str.toString()
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;")
      .replace(/\"/g, "&quot;")
      .replace(/\'/g, "&apos;");
};


function serialize_sections(section_name, items) {
   // expects an array of objects, key objects in this instance.
   let itemsXML = items.map(item => `
      <sign>
         <key>${escapeXML(item.key)}</key>
         <description>${escapeXML(item.description)}</description>
         <count>${escapeXML(item.count)}</count>
         <cost>${escapeXML(item.cost)}</cost>
         <total_cost>${escapeXML(item.total_cost)}</total_cost>
      </sign>
      `).join("");
   
   let section_info = `
   <section>
   <section_name>${section_name}</section_name>
   ${itemsXML}
   </section>
   `;

   return section_info;
}

function serialize_unique_signs(unique_sign_arr) {
   function section_list_xml(section_list) {
      let list = section_list.map(section_key => `
         <section_key>
            <key>${escapeXML(section_key.key)}</key>
            <section>${escapeXML(section_key.section)}</section>
         </section_key>
         `).join("");
      return list;
   };
   
   let unique_items_xml = unique_sign_arr.map(unique_sign => `
      <unique_sign>
         <section_list>
            ${section_list_xml(unique_sign.section_list)}         
         </section_list>
         <description>${escapeXML(unique_sign.description)}</description>
         <total_count>${escapeXML(unique_sign.count)}</total_count>
         <each_cost>${escapeXML(unique_sign.cost)}</each_cost>
         <total_cost>${escapeXML(unique_sign.total_cost)}</total_cost>
      </unique_sign>
      `).join(""); 
   return unique_items_xml;
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
   make_folder()

   function make_folder(folder_name) {
      const folder_path = path.join(destination_path, `/${"000-json_data"}`);
      fs.access(folder_path, fs.constants.F_OK, (err) => {
         if (err) {
            console.log(`${folder_name} does not exist, creating.`);
            fs.mkdir(folder_path, (err) => {
               if (err) {
                  console.log("Making folder failed.");
               }
            });
         } 
      });
   }

   function write_json_lib(data, file_path) {
      const full_path = path.resolve(file_path);
      try {
         const new_data = JSON.stringify(data);
         const json_name = json_file_name(data);
         const file_name = path.basename(full_path);
         const new_path = path.join(destination_path, json_name);
         fs.writeFile(new_path, new_data, (err) => {
            if (err) {
               console.error('Error writing json file:', err);
            } else {
               console.log('Json file written successfully.');
            }
         });
      } catch(err) {
         console.log(`Failure to write json file: ${err}`);
      }
   }
   
   function write_xml_lib(data, file_path) {
      const full_path = path.resolve(file_path);
      const file_name = path.basename(full_path);
      make_folder("000-xml_data");
      try {
          let xml_data = build_xml_object(data);
          const xml_name = xml_file_name(data) 
          const new_path = path.join(destination_path, xml_name);
          fs.writeFile(new_path, xml_data, (err) => {
            if (err) {
               console.error('Error writing xml file: ', err);
            } else {
               console.log('xml file written successfully.');
            }
          });
      } catch(err) {
         console.log(`Failure to construct XML file: ${err} \n File: ${file_name}`);
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
         //write_json_lib(target_data, full_path);
         write_xml_lib(target_data, full_path);
         export_data(target_data, new_file_path);
         console.log(`Processed clean contract, saved to: ${new_file_path}`)
         // console.log(target_data);
         // console.log(test_complete_row(target_data))
      } catch(err) {
         console.log(`Process Error: ${err}, ${full_path}`)
      }
   }
   file_paths.forEach((path) => process_file(path));
}

batch_test_clean_contracts();
