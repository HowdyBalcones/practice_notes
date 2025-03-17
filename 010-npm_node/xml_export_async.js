const XLSX = require('xlsx');
const fs = require('fs');
const path = require('path');

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
   // input is a json object representing an AoO, each row is an index in the parent arr, value of a row is array-like obj with 
   // "index" keys, and values representing data in "cells"
   let section_map = new Map();
   try {
      for (let i = 1; i < data.length; ++i) {
         let row = data[i];
         let section_name = row["0"];
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

async function build_section_xml(section_map) {
   const section_map_array = Array.from(section_map);
   let xml_sections = '';
   for (let i = 0; i < section_map_array.length; ++i) {
      let section_arr = section_map_array[i];      // array
      let section_name = section_arr[0].trim();    // string
      let section_row_arr = section_arr[1];        // sub-array of section_arr, contains list of key objects
      let values_object = section_row_arr[0];      // this is the key object? idk if I still need, wrote it for testing.
      console.log(section_row_arr);
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

async function compose_xml_object(data) {
   try {
      const section_map = await build_section_xml(data);
      const section_xml = await build_section_xml(section_map);
      const metadata_xml = await build_metadata_xml(data);
      console.log(section_xml, metadata_xml);
   } catch(xml_comp_err) {
      console.error(xml_comp_err);
   }
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

async function serialize_unique_signs(unique_sign_arr) {
   function section_list_xml(section_list) {
      let list = section_list.map(section_key => `
         <section_key>
            <key>${escapeXML(section_key.key)}</key>
            <section>${escapeXML(section_key.section)}</section>
         </section_key>
         `).join("");
      return list;
   }

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
           compose_xml_object(target_data);
           console.log(target_data['0']);
           // write_xml_lib(target_data, full_path);
           console.log(file_path);
         } catch(write_err) {
            console.log(`Error writing file: ${file_name}`)
         }

      } catch(err) {
         console.log(`Process Error: ${err}, file_name: ${file_name}`)
         console.log()
      }
   }

   try {
      console.log(destination_path, file_paths);
      file_paths.forEach((path) => process_file(path));
   } catch(process_err) {
      console.error(`Process error: ${process_err}`);
   }

}

batch_files();
