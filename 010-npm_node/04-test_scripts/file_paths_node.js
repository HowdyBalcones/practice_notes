const path = require('path');

// this is an example of using node to access file paths

const fullPath = path.join(__dirname, 'folder', 'file.txt');
console.log('Full Path:', fullPath);

const fileName = path.basename(fullPath);
console.log('File Name:', fileName);

const dirName = path.dirname(fullPath);
console.log('Directory Name:', dirName);

const ext = path.extname(fullPath);
console.log('File Extension:', ext);
