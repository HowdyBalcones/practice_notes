// goal: write an excel doc containing all the unique signs in a batch of input contracts. 

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

async function export_data(json_obj, file_path) {
   const new_workbook = XLSX.utils.book_new();
   let worksheet = XLSX.utils.json_to_sheet(json_obj);
   XLSX.utils.book_append_sheet(new_workbook, worksheet, "Sheet 1");
   XLSX.writeFile(new_workbook, file_path, { compression: true });
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

async function build_unique_sign(row) {
   const count = row["2"];
   const description = row["3"];
   const contract = row["11"];
   let unique_sign = {
      "description": description,
      "count": count,
      "contract_list": [contract],
      add_contract(new_contract) {
         if (!this.contract_list.includes(new_contract)){
            this.contract_list.push(new_contract);
         } 
      }
   }
   return unique_sign;
}

async function unique_signs(data) {
   let unique_sign_list = [];
   for (let i = 1; i < data.length; ++i) {
       let row = data[i];
      const new_obj = await build_unique_sign(row);
      unique_sign_list = await find_same_obj(unique_sign_list, new_obj);
   }
   return unique_sign_list;
}

async function find_same_obj(arr, new_obj) {
   const new_arr = [...arr];
   const existing_obj = new_arr.find(obj => obj.description === new_obj.description);
   if (existing_obj) {
      existing_obj.count += new_obj.count || 1;
      existing_obj.add_contract(new_obj.contract_list[0]);
   } else {
      new_arr.push({...new_obj, count: new_obj.count || 1});
   }
   return new_arr;
}

function sort_big_contract(big_contract) {
   let sorted_contract = [...big_contract];
   sorted_contract.sort((a,b) => {
      if (typeof a.description !== 'string' || typeof b.description !== 'string') {
       if (typeof a.description !== 'string' && typeof b.description !== 'string') {
         return 0;
      } else if (typeof a.description !== 'string') {
         return 1;
      } else {
         return -1
      }
   }
   return a.description.localeCompare(b.description);
   });
   return sorted_contract;
}

async function build_compound_contract() {
   const file_paths = process.argv.slice(3);
   const destination_path = process.argv[2];
   if (file_paths.length === 0) {
      console.error('No files provided: Usage node script destination files...');
      process.exit(1);
   } 
   async function append_contracts(file_list) {
      let compound_contract = [];
      for (let i = 0; i < file_list.length; ++i) {
         let file_path = file_list[i];
         try {
            const full_path = path.resolve(file_path);
            if (!full_path) {
               console.log(`Error resolving file_path: ${full_path}`);
               return;
            }
            file_name = path.basename(full_path);
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
               compound_contract.push(target_data);
            } catch(err) {
               console.error(`Contract Error: Cannot import file ${file_name}\n${err}`);
            }
         } catch(err) {
            console.error(`Contract Error: Cannot append contract ${file_path}\n${err}`);
         }
      }
      return compound_contract;
   }
   const big_contract = await append_contracts(file_paths);
   const flattened_big_contract = big_contract.flat();
   const unique_signs_from_big_contract = await unique_signs(flattened_big_contract);
  // const sorted_unique_signs = await unique_signs_from_big_contract.sort((a,b) => {
  //    if (a.name < b.name) return -1;
  //    if (a.name > b.name) return 1;
  //    return 0;
  // });
   // const sorted_unique_signs = unique_signs_from_big_contract.sort((a, b) => a.description.localeCompare(b.description));
   const sorted_unique_signs = sort_big_contract(unique_signs_from_big_contract);
   const final_unique_sign_list = sorted_unique_signs.map((sign) => ({
      ...sign,
         contract_list: sign.contract_list.join('\n'),
   }));
   export_data(final_unique_sign_list, `${destination_path}/compound_contract.xlsx`);
   console.log(sorted_unique_signs);

}

build_compound_contract();
