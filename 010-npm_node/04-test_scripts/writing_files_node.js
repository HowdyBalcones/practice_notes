const fs = require('fs');
const path = require('path');

// this is just an example of writing to files with node js
// we really only need fs here

// async
fs.writeFile('test1.txt', 'Hello World Dos', (err) => {
   if (err) {
      console.error('Error writing file:', err);
      return;
   }
   console.log('File written successfully');
});

// sync
try {
   fs.writeFileSync('test2.txt', "AND ANOTHER ONE");
   console.log("File written successfully");
} catch(e) {
   console.log("Error writing file:", e);
}
