const fs = require('fs');
const path = require('path');

// getting commandline arguments: skip the first two arguments, the call to node and the script path
const file_paths = process.argv.slice(2); // argv contains the args passed to your script as an array

if (file_paths.length === 0) {
   console.error('No files provided. Usage: node scriptFile.js file1 file2 etc...');
   process.exit(1);
}

function process_file(file_path)
{
   try {
      const full_path = path.resolve(file_path);
      
      // check the file exists synchronously
      if (!fs.existsSync(full_path)) {
         console.error(`File not found: ${full_path}`);
         return;
      }
      
      // this stores the files data, will be extension specific
      const data = fs.readFileSync(full_path, 'utf-8');

      // at this point the data in the file can be altered
      // this just converts the characters in a text file to uppercase
      const processed_data = data.toUpperCase();

      // the processed data needs to be written for there to be a meaningful effect
      const new_file_path = path.join(path.dirname(full_path), `processed_${path.basename(full_path)}`);
      // use the writeFileSync method, pass in the joined path name and the data to be written to the new name
      fs.writeFileSync(new_file_path, processed_data);
      console.log(`Processed file saved: ${new_file_path}`);
   } catch(e) {
      console.error(`Error processing file ${file_path}:`, e);
   }
}

file_paths.forEach(process_file);
