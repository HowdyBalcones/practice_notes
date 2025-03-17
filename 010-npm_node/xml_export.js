const XLSX = require('xlsx');
const fs = require('fs');
const path = require('path');
// TODO
// -- error when there are slashes in the name, need to scrub the file names for illegal chars
// -- error serializing the unique signs section. It's adding in an extra job_info tag, and I haven't determined why. 

// this probably doesn't need to exist, since we are writing xml only. 
function export_data(workbook, file_path) {
   const new_workbook = XLSX.utils.book_new();
   let worksheet = XLSX.utils.json_to_sheet(workbook);
   XLSX.utils.book_append_sheet(new_workbook, worksheet, "Sheet 1");
   XLSX.writeFile(new_workbook, file_path, { compression: true });
}

// this just needs to bring in the json object from the xlsx file. 
function import_clean_contract(path, file_name) {
   const workbook = XLSX.readFile(path);
   const sheet_name = workbook.SheetNames[0];
   let sheet = workbook.Sheets[sheet_name];
   const raw_data = XLSX.utils.sheet_to_json(sheet, {
      blankrows: true
   });
   let filtered_data = raw_data;
   try {
  } catch(e) {
      console.log(`Import Error: ${e}`);
   }
   return filtered_data;
}

function xml_file_name(data) {
   const job_regex = /\//g;
   let data_row = data[2];
   let job_num = data_row["8"];
   let job_name = data_row["10"];
   // job_name = job_name.replace(job_regex, "");
   let file_name = `${job_num}--${job_name}.xml`;
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
   const data_row = data[1];

   const client_name = data_row["6"];
   const quote_num = data_row["8"];
   const project_name = data_row["10"];
   const contract_file = data_row["11"];

   let section_map = new Map();
   let xml_object = '';
   let xml_sections = '';
   
   // this is what a row from the contract becomes, only includes essential cells but is flexible what can be included. 
   
   try {
   for (let i = 1; i < data.length; ++i) {
      let row = data[i];
      let section_name = row["0"];

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

   // content in unique signs list is made here.
   // const signs_to_serialize = await unique_signs(data);
   // const unique_signs_xml = `
   //   ${serialize_unique_signs(signs_to_serialize)}
   // `
   // metadata section serialized here 
   const metadata = `
   <quote_num>${escapeXML(quote_num)}</quote_num>
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
      </unique_sign_list>
      </job_info>
      `
      
   } catch(err) {
      console.log(`Error serializing XML: ${err}`);
      throw err;
   }
   return xml_object;
}

function unique_signs(data) {
   let unique_sign_list = [];
   
   for (i = 1; i < data.length; ++i) {
      let row = data[i];
      const new_obj = build_key_obj(row);
      unique_sign_list = find_same_obj(unique_sign_list, new_obj);
   }
   return unique_sign_list;
}

function find_same_obj(arr, new_obj) {
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

function escapeXML(str) {
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
   const itemsXML = items.map(item => `
      <sign>
         <key>${escapeXML(item.key)}</key>
         <description>${escapeXML(item.description)}</description>
         <count>${escapeXML(item.count)}</count>
         <cost>${escapeXML(item.cost)}</cost>
         <total_cost>${escapeXML(item.total_cost)}</total_cost>
      </sign>
      `).join("");
   
   const section_info = `
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
   
   const unique_items_xml = unique_sign_arr.map(unique_sign => `
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
   if (file_paths.length === 0) {
      console.error('No files provided: Usage node script destination files...');
      process.exit(1);
   }

   async function make_folder_async(folder_name) {
      const folder_path = path.join(destination_path, `/${folder_name}`);
      try {
        await fs.mkdir(folder_path, {recursive: true}, (err) => {
            if (err) {
               console.log(err);
            }
         });
     } catch(err) {
        if (err.code === 'EEXISTS') {
           console.log('Folder already exists.')
        } else {
           console.error(`Error writing the file: ${folder_path}`, err);
        }
      }
   }
 
   function write_xml_lib(data, file_path) {
      const xml_folder_name = '000-xml_lib';
      make_folder_async(xml_folder_name);
      try {
          let xml_data = build_xml_object(data);
          const file_name = path.basename(file_path, '.xlsx');
          const new_path = path.join(`${destination_path}/${xml_folder_name}`, `${file_name}.xml`);
          fs.writeFile(new_path, xml_data, (err) => {
            if (err) {
               console.error('Error writing xml file: ', err);
               throw err;
            } else {
               console.log('xml file written successfully.');
            }
          });
      } catch(err) {
         console.log(`Failure to construct XML file: ${err} \n File: ${file_name}`);
      }
   }

   function process_file(file_path) {
      let file_name = 'unknown';
      try {
         const full_path = path.resolve(file_path);
         if (!full_path) {
            console.log(`Error resolving file_path: ${file_path}`);
            return;
         }
         file_name = path.basename(full_path);
         if (!file_name) {
            console.log(`Cannot resolve file_name: ${full_path}`)
            return;
         }
         if (!fs.existsSync(full_path)) {
            console.error(`File not found: ${file_path}`);
            return;
         }
         
         try {
            const target_data = import_clean_contract(full_path, file_name); 
            if (!target_data) {
               console.log(`Error reading file: ${file_name}`);
               return;
            }
            write_xml_lib(target_data, full_path);
         } catch(write_err) {
            console.log(`Error writing xml file: ${file_name}`)
         }

      } catch(err) {
         console.log(`Process Error: ${err}, file_name: ${file_name}`)
         console.log()
      }
   }
   file_paths.forEach((path) => process_file(path));
}

batch_test_clean_contracts();
