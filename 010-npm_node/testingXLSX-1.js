const XLSX = require("xlsx");

const workbook = XLSX.utils.book_new();
const worksheetData = [
   ["Hello", "World"],
   ["Testing", "this"],
   ["New library", "at work"]
];
const worksheet = XLSX.utils.aoa_to_sheet(worksheetData);

XLSX.utils.book_append_sheet(workbook, worksheet, "Sheet1");
XLSX.writeFile(workbook, "hello_world.xlsx");
console.log("Excel file created: hello_world.xlsx");

const readWorkbook = XLSX.readFile("hello_world.xlsx");
const readWorksheet = readWorkbook.Sheets["Sheet1"];
const readData = XLSX.utils.sheet_to_json(readWorksheet, { header: 1 });

console.log("Data read from Excel file:");
console.log(readData);
