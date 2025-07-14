const XLSX = require('xlsx');
const fs = require('fs');
const path = require('path');
const fuzzy = require('./fuzzy_find-01.js');

async function import_clean_contract(path, file_name) {
   const workbook = await XLSX.readFile(path);
   const sheet_name = await workbook.SheetNames[0];
   let sheet = await workbook.Sheets[sheet_name];
   const raw_data = await XLSX.utils.sheet_to_json(sheet, {
      blankrows: true
   });
   let filtered_data = raw_data;
   try {
  } catch(e) {
      console.log(`Import Error: ${e}`);
   }
   return filtered_data;
}

function build_key_obj(row) {
   // Takes json object keys and turns it into a generic object
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

function escapeXML(str) {
   if (!str) return "";
   return str.toString()
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;")
      .replace(/\"/g, "&quot;")
      .replace(/\'/g, "&apos;");
};

async function create_section_map(data) {
   // input is a json object representing an AoO, each row is an index in the 
   // parent arr, value of a row is array-like obj with 
   // "index" keys, and values representing data in "cells"
   let section_map = new Map();
   try {
      for (let i = 1; i < data.length; ++i) {
         let row = data[i];
         let section_name = row["0"].trim();
         if (!section_map.has(section_name)) {
            section_map.set(section_name, []);
         }
         section_map.get(section_name).push(build_key_obj(row));
      }
   } catch(map_err) {
      console.error(map_err);
   }
   return section_map;
}

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

async function build_section_xml(section_map) {
   const section_map_array = Array.from(section_map);
   let xml_sections = '';
   for (let i = 0; i < section_map_array.length; ++i) {
      let section_arr = section_map_array[i];      // array
      let section_name = section_arr[0].trim();    // string
      let section_row_arr = section_arr[1];        // sub-array of section_arr, contains list of key objects
      xml_sections += serialize_sections(escapeXML(section_name), section_row_arr);
   }
   return xml_sections;
}

async function build_metadata_xml(data) {
   const data_row = data[1];
   const client_name = data_row["6"];
   const quote_num = data_row["8"];
   const project_name = data_row["10"];
   const contract_file = data_row["11"];
   const metadata =  `
   <quote_num>${escapeXML(quote_num)}</quote_num>
   <contract_file>${escapeXML(contract_file)}</contract_file>
   <client_name>${escapeXML(client_name)}</client_name>
   <project_name>${escapeXML(project_name)}</project_name>
   <project_address></project_address>
   <designer_name></designer_name>
   `
   return metadata;
}

async function unique_signs(data) {
   let unique_sign_list = [];
   for (let i = 1; i < data.length; ++i) {
      let row = data[i];
      const new_obj = await build_key_obj(row);
      unique_sign_list = await find_same_obj(unique_sign_list, new_obj);
   }
   return unique_sign_list;
}

async function find_same_obj(arr, new_obj) {
   const new_arr = [...arr];
   // fix this
   const existing_obj = new_arr.find(obj => obj.description === new_obj.description);
   if (existing_obj) {
      existing_obj.count += new_obj.count || 1;
      existing_obj.set_total_cost();
      existing_obj.section_list.push(new_obj.section_list[0]);
   } else {
      new_arr.push({...new_obj, count: new_obj.count || 1});
   }
   return new_arr;
}

async function serialize_unique_signs(unique_sign_arr) {
  let unique_items_xml = '';
  async function section_list_xml(section_list) {
      let list = section_list.map(section_key => `
         <section_key>
            <key>${escapeXML(section_key.key)}</key>
            <section>${escapeXML(section_key.section)}</section>
         </section_key>
         `).join("");
      return list;
   }
   
   for (let i = 0; i < unique_sign_arr.length; ++i) {
      const unique_sign = unique_sign_arr[i];
      const section_list = await section_list_xml(unique_sign.section_list);
      const description = escapeXML(unique_sign.description);
      const total_count = escapeXML(unique_sign.count); 
      const each_cost = escapeXML(unique_sign.cost);
      const total_cost = escapeXML(unique_sign.total_cost);
      unique_items_xml += `
      <unique_sign>
         <section_list>
         ${section_list}
         </section_list>
         <description>${description}</description>
         <total_count>${total_count}</total_count>
         <each_cost>${each_cost}</each_cost>
         <total_cost>${total_cost}</total_cost>
      </unique_sign>
      `
   }

   return unique_items_xml;
}

async function compose_xml_object(data) {
   try {
      let xml_object = '';
      const section_map = await create_section_map(data);
      // console.log(section_map)
      const section_xml = await build_section_xml(section_map);
      // console.log(section_xml);
      const metadata_xml = await build_metadata_xml(data);
      const unique_sign_list = await unique_signs(data);
      const unique_sign_xml = await serialize_unique_signs(unique_sign_list);
      xml_object = `
      <job_info>
      <metadata>
      ${metadata_xml}
      </metadata>
      <contract>
      ${section_xml}
      </contract>
      <unique_sign_list>
      ${unique_sign_xml}
      </unique_sign_list>
      </job_info>
      `
      // console.log(xml_object)
      return xml_object;
   } catch(xml_comp_err) {
      console.error(xml_comp_err);
   }
}

// main batch processing, the cli interface
async function batch_files() {
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

   async function write_xml_lib(data, file_path) {
      const file_name = path.basename(file_path, '.xlsx');
      const xml_folder_name = '000-xml_lib';
      make_folder_async(xml_folder_name);
      try {
         const xml_object = await compose_xml_object(data);
         const new_path = path.join(`${destination_path}/${xml_folder_name}`, `${file_name}.xml`);
         fs.writeFile(new_path, xml_object, (err) => {
            if (err) {
               console.error('Error writing xml file: ', err);
               throw err;
            } else {
               console.log('xml file written successfully.');
            }
         });
      } catch(err) {
         console.log(`Failure to construct XML file: ${err}\n File: ${file_name}`);
      }
   }

   async function process_file(file_path) {
      let file_name = 'unknown';
      try {
         const full_path = await path.resolve(file_path);
         if (!full_path) {
            console.log(`Error resolving file_path: ${file_path}`);
            return;
         }

         file_name = await path.basename(full_path);
         if (!file_name) {
            console.log(`Cannot resolve file_name: ${full_path}`)
            return;
         }

         try {
           const target_data = await import_clean_contract(full_path, file_name);
           if (!target_data) {
              console.log(`Error reading file: ${file_name}`);
              return;
           }
           write_xml_lib(target_data, full_path);
         } catch(write_err) {
            console.log(`Error writing file: ${file_name}`)
         }

      } catch(err) {
         console.log(`Process Error: ${err}, file_name: ${file_name}`)
      }
   }

   try {
      file_paths.forEach((path) => process_file(path));
   } catch(process_err) {
      console.error(`Process error: ${process_err}`);
   }

}

batch_files();
