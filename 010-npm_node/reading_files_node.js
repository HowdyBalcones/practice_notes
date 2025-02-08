const fs = require('fs');
const path = require('path');

// how to use node to read a file

// async
fs.readFile('./file1.txt', 'utf-8', (err, data) => {
   if (err) {
      console.log('Error reading file:', err);
      return;
   }
   console.log('File Content:', data);
});

// synchronous
try {
   const data = fs.readFileSync('./file2.txt', 'utf-8');
   console.log('File Content:', data);
} catch(e) {
   console.error('Error reading file:', e);
}


