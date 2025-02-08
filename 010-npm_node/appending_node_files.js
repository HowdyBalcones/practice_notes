const fs = require("fs");

fs.appendFile("./test1.txt", "\nADDED THIS HELLO", (err) => {
   if (err) {
      console.log("Error appending the file", err);
      return;
   }
   console.log("File successfully appended");
});

try {
   fs.appendFileSync('./test2.txt', "\nTHIS IS TEXT TO BE APPENDED");
   console.log("File successfully appended");
} catch(e) {
   console.log("Error appending file", e);
}
