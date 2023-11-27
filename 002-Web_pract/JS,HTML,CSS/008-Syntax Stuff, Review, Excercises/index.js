// console.log("Dang ol Planet")

// //ES6 (fat) Arrow Functions
// //work best in call back function queries
// // parentheses around input if there are more than one
// // curly braces around function body if more than one line of code
// // return only needed if more than one line of code

// //What is a callback function?

// let numbers = [123, 234, 345, 456, 567];
// let names = ["Alex", "Bree", "Cara", "Cole", "Devon", "Riley"];

// let big = numbers.filter(function(item){
// 	return item > 300
// });



// let bigA = numbers.filter(	item	=> item > 300);

// console.log(big);
// console.log(bigA);

// // example of arrow function using two parameters

// //standard syntax
// names.forEach(function(item,index){
// 	console.log(index,item);
// })

// //arrow function syntax
// names.forEach((item,index) => console.log(index,item));


// //Variable Scope ---

// let name = "Aragorn"; //this is known as a global variable


// function x(){
// 	name = "Gimli"; //this is known as a local variable// without var or let, this reassigns the variable
// 	other = "Legolas"; //with no global variable, the local variable without a declaration will be converted to a global one
// 	console.log(name);

// }

// function y(){
// 	console.log(name);
// }

// x();
// console.log(name) // this is being declared globally
// y(); // this is being declared within the function y(), with no local variable it pulls the global name
// console.log(other);

// Hoisting ---
// the process of taking two passes through the js file_exists
//first pass hoists all the declarations to the top of the file



// let a;
// let b = 4;

// // console.log(d);//undefined
// console.log(c());

// function c(){ // since this is a function declaration, it is hoisted to the top
// 	//function declaration
// 	console.log("Booty")
// }

// let d = 5;
// let e = function(){
// 	//function expression

// }

//variable scope ---

// var ranger = "Aragorn";
// let elf = "Legolas"; // the let variable allows for block level scope
// const DWARF = "Gimli"; // this is also a new one in ES6 (old now?), unchanging, cannot be reassigned
// let hobbit = "Sam";

// function goToMountDoom(){
// 	for(var i=0;i<100;i++){
// 	//i is a local scope variable

// 	}
// 	for(let c=0;c<100;c++){
// 	//c is a block scope variable, this means it will only exist within the scope of the function
// 	//more restrictive, let is better apparently for this reason
// 	}
// 	console.log("i",i);
// 	console.log("c",c);
// 	let hobbit = "Frodo";
// }

// function visitLothLorien(){
// 	elf = "Galadriel";
// 	ranger = "Strider";
// 	DWARF = "Gloin";
// 	let hobbit = "Bilbo";
// }

// goToMountDoom();
// visitLothLorien();

// Strings but good this time ---

// let str1 = new String("Toy Story"); // create new string object
// let str2 = String("Wall-e"); // taking string value and turn the contents into string
// let str3 = "Cars"; // this is a string literal

// let result = str1.toUpperCase();
// let result2 = "Monsters Inc".toLowerCase();
// let newArray = []

// console.log(str1,result);
// console.log(result2);

// let r = str2.substring(4,5)
// let g = str2.substr(4,1)
// let h = str2.slice(4,1)
// console.log(r)
// console.log(g)
// console.log(h)

// // // self excercise; take array and turn each string into variable, then convert to uppercase

let bigArray = ["Rhonda","Empty","Camden","Gilbert","Nicole","Seth","Ryan","Rafiq","Spencer","Empty","Robert/Sebastion"]

// console.log(bigArray.slice(2,-5)) // with slice, negative number will begin from the end of an array
// console.log(bigArray.slice(0,-4))

// let y = bigArray.indexOf("Empty")
// console.log(y)

// let o = "".concat(str1, ", ", str2, ", ", str3)
// console.log(o)

// function convertArrayUpper(){
// 	for(let i=0;i<bigArray.length;i++){
// 	let toString = String(i)
// 	toString.toUpperCase();
// 	newArray.push(toString)
// 	}
// }


// convertArrayUpper();
// console.log(bigArray)
// console.log(newArray)

// let upperArray = bigArray.toUpperCase();
// let lowerArray = bigArray.toLowerCase();

// console.log(upperArray)
// console.log(lowerArray)

// well that didnt work

// let x = bigArray.join(" ").toUpperCase().toLowerCase()
// console.log(x)
// console.log(bigArray)

// //this did tho :^P

//Escape & Unicode ---
//Unicode Characters in Javascript
//escape sequences in Javascript
// http://www.unicode.org/charts/
// String.fromCharCode(num[, num,num])
//myString.charCodeAt(index)
// \u0434
// \0 \' \" \\ \n \r \t

// let yesRU = "\u0434\u0430"; //yes in Russian
// let milkDK = "m\u00E6lk"; //milk
// let breadNO = "br\u00F8d";
// let tomorrowES = "ma\u00F1ana";
// let emojiJP = "\u3047\u3082\u3058";

// console.log(yesRU,milkDK,breadNO,tomorrowES,emojiJP)
// let log = console.log
// log("\"\\a\t\ta\n\ta");


//Global Functions & Math --- IMPORTANT

// let r = parseInt("234", 10) // parseInt() returns string as number, second parameter is the base number, like base 10 or 16
// //this is crucial but I don't know why, it can convert human readable numbers to machine code tho

// console.log(r)

// let num = 234.09876456;

// // r = Number.parseInt(num);
// console.log(r);

// //toFixed() - decides the number of decimal places that are returned

// r = num.toFixed(7);
// console.log(r)

// r = Math.round(num)
// // r = Math.floor(num)
// r = Math.ceil(num)
// console.log(r)

// r = Math.random();
// console.log(r)

// r = Math.max(89, 56, 23, 744) // returns the largest number within the object
// console.log(r)


//String.split & Array.join --- IMPORTANT

// //converting strings to arrays and arrays to strings
// //string to array = str.split();
// //array to string = arr.join();

// let sentence = "Hello my name is Inigo Montoya"
// let log = console.log

// log(sentence)

// let words = sentence.split(" ").sort();
// console.log(words);

// // let chars = sentence.split(" name ")
// // log(chars)

// let chars = sentence.split("");
// log(chars)

// let hyphenated = words.join(" - ");
// log(hyphenated)

// let oneWord = words.join("");
// log(oneWord)

// let x = sentence.split(" ").sort().join(" ");
// log(x)

// Array forEach method --- IMPORTANT

//Array forEach loop
// call a function for each item in an array


// let dwarves = ["Bifur", "Bofur", "Bombur", "Fili", "Kili", "Oin", "Gloin", "Thorin", "Balin", "Dwalin", "Nori", "Dori"];

// dwarves.forEach(function(item, index, array){

// if (item === "Thorin"){
// 	item = item.toUpperCase();
// }else{
// 	item = item.toLowerCase();
// }

// console.log(index,item)
// });

// Array map() method --- IMPORTANT

// let dwarves = ["Bifur", "Bofur", "Bombur", "Fili", "Kili", "Oin", "Gloin", "Thorin", "Balin", "Dwalin", "Nori", "Dori"];

// // determine the length of each name and save it in an Array
// //difference between forEach and map is - forEach is affecting the original array
// // map is giving you a new array 


// let nameLength = dwarves.map(function(item,index,array){
	
// 	// let len = item.length;
// 	// return len; // requires a return 
// 	return item.length // this also works
// })

// console.log(nameLength)

// //array filter() methods --- IMPORTANT

// let numbers = [23,45,14,66,94,33,4,9,67,113,235];
// let breakPoint = 30;

// let smallNumbers = numbers.filter(function(num){
// 	return num < breakPoint;

// })

// let bigNumbers = numbers.filter(function(num){
// 	return num > breakPoint;
// })

// // //this also works
// // function checkBig(num){
// // 	return num > breakPoint;
// // }

// // let bigNumbers = numbers.filter(checkBig)

// let oddNumbers = numbers.filter(function(num){
// 	let remainder = num%2;
// 	//alternatively you can use a bitwise operator

// 	// 0, 1, 10, 11, 100, 101, 110, 111, 1000
// 	// 0, 1, 2, 3, 4, 5, 6, 7, 8
// 	// return num & 1; // this checks if the number is odd or even
// 	return num = remainder
// })

// console.log("\nSmaller than 30:", smallNumbers)
// console.log("\n Larger than 30:", bigNumbers)
// console.log("\n Odd numbers:", oddNumbers)




// IT IS TIME FOR THE REDUCE METHOD AND POTENTIALLY FINISHING THE UPC GENERATOR
// Array reduce method
//reduce all the values in an array into a single result
// uses a callback function just like map(), forEach(), filter(), etc
//array.reduce(callback, initialValue)
//also has a second parameter which is an initialValue


let numbers = [12,34,56,78,91];
//find the sum of all the numbers



let movies = ["Star Wars", "Star Trek", "Jaws", "Jurassic Park", "Gross Pointe Blank", "Eternal Sunshine of the Spotless Mind", "Memento", "Dog Soldier", "The Most", "Gran Torino", "Close Encounters of the Third Kind", "Good Will Hunting", "Layer Cake", "Casino Royale", "Almost Famous"]
//find the first movie alphabetically

let sum = numbers.reduce(function(passedIn, item){
	return passedIn + item;

}, 0);



console.log("Total is", sum, "\n");

let first 
console.log("First Movie is", first);










































