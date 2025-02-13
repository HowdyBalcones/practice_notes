function using_argv() {
   let greetings = process.argv.slice(2);
   console.log(`The Array: ${greetings}`);
   for (greeting in greetings) {
      console.log(`The indices: ${greeting}`);
   }
   greetings.forEach((element) => console.log(`The elements: ${element}`))
}

using_argv();
