const XLSX = require('xlsx');

const file = "./2211AM01S Fairmount Signage REV 1.xlsx;


function extractData(filePath) {
   const workbook = XLSX.read(file);
   const sheetNames = workbook.SheetNames;
   
   const sheet = workbook.Sheets[sheetNames[0]];
   
   let data = XLSX.utils.sheet_to_json(sheet, { header: 1 });
   return sheet;
}

const data = extractData(file);
console.log(data);
