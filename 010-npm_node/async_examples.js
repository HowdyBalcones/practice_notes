// this is some reference for async functions, promises, and related
// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/async_function
// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise
// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Using_promises
// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise/then
//

// basic syntax -- async functions return a promise object. use .then() to resolve the promise. 
// await -- used to wait for a promise object to return a value.
async function fetch_data() {
   return "Some value that's being fetched";
}

async function fetch_data_pause() {
   const data = await new Promise((resolve) => {
      setTimeout(() => resolve("Data that is fetched after pause"), 2000);
   });
   console.log(data);
}

async function fetch_data_then() {
   const a_string = "SOME STRING";
   return a_string;
}

async function append_string(input_str, added_str) {
   return `${input_str} ${added_str}`;
}
async function imaginary_async() {
   const imaginary_list = [];
   const url = await do_something();
   const res = await fetch(url);
   const data = await res.json();
   imaginary_list.push(data);
   console.log(imaginary_list);
}

async function using_await(str) {
   try {
       const str_1 = await append_string(str, "added once");
       const str_2 = await append_string(str_1, "added twice");
       const str_3 = await append_string(str_2, "added thrice");
       console.log(str_3);
   } catch(e) {
      console.log(e);
   }
}

fetch_data_pause();
fetch_data().then((result) => console.log(result));
fetch_data_then()
   .then((result) => `${result} WITH ADDED TEXT`)
   .then((result_2) => append_string(result_2, "AND A THIRD STRING"))
   .then((final_result) => console.log(final_result));
using_await("STARTING STRING");
