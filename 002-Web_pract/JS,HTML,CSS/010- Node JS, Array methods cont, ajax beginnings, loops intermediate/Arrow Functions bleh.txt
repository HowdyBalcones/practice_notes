//constants
let numbers1=[12,10,2,16,78,95,23,67,353,112,8786,234,7345,-123,666,987]
let dwarves = ["Gordon", "Michael", "Gloinor", "Stumpy", "Talls", "Long Gears", "Bushy Brow", "Zannoying","Tingle","Dingle","Gimli","Anvil Chin"]
let people = [
	{"id":123 ,"name":"Ricky Booby" ,"email":"rick@gmail.com"},
	{"id":456 ,"name":"Sigourney Weaver" ,"email":"thecompletebabe@hotmail.com"},
	{"id":678,"name":"Action Man Template" ,"email":"generoViolence@gmail.com"},
	{"id":8910 ,"name":"Cartmann Blue Hat" ,"email":"southpark@hotmail.com"},
	];
//****************************************************************************************
// What in the name of Blister Pack is AJAX? 
//What is fetch() method and why is it my daddy? 
//It makes an http request, so I will also need to learn about http headers and requests
//Uses Promises


//****************************************************************************************
// //Combo BRRRReaker! --- Or How I learned to stop fearing Javascript arrow functions

// //two step version--

// //this goes through the people array, checks the email tag, creates a new array containing the emails that match the search keywords
// let characters = people.filter(function(person){
// 	return person.email.indexOf("@hotmail.com") > -1;
// });

// //this creates a new array based on the characters array data, returns the name for each item in the array
// let names = characters.map(function(person){
// 	return person.name
// });

// console.log(characters)
// console.log("List of character names", names);

// //chain the two steps--

// let characterNames = people.filter(function(person){
// 	return person.email.indexOf("@hotmail.com") > -1;
// }).map(function(person){
// 	return person.name
// })


// console.log("List of character names", characterNames);

// //arrow function version-- What an excellent example

// let rn = people.filter(person=>person.email.indexOf("@gmail.com")> -1).map(person => person.name);
// console.log("List of character names", rn);
//****************************************************************************************

// console.log("BoyHowdYDo")

// function messing(){
// 	for(i=0;i<40;i++){
// 		console.log("Is this Thing On?")
// }
// }

// messing()
//****************************************************************************************

// //includes() practice 1 ---

// let name1 = "Peter Dinklage"
// let name2 = "Kenny Baker"
// let name3 = "Happy"
// let name4 = "Zannoying"
// let name5 = "Gordon"

// let hasPeter = dwarves.includes(name5, name4); //should return true or false

// console.log("Contains Peter", hasPeter);

//****************************************************************************************
// //some() practice 1 ---

// let keyword1 = "Chin"
// let keyword2 = "Gears"
// let keyword3 = "Dingle"

// let testSome = dwarves.some(function(title,index){
// 	console.log("Some Practice",index,title)
// 	return title.indexOf(keyword3) > -1 ; // is keywordx found within the title, using indexOf to search
// 	//each title for the passed in keyword. 

// });

//****************************************************************************************
//every() Array method ---
//checks every element for the condition and returns true or false.

//the passed in function is going to be given three things by the every() method
//this is what was confusing me, where the parameters were supposed to come from

// let greaterThan20 = numbers1.every(function(num){
// 	return num> -1000;
// });

// console.log("Is every number greater than -1000? ", greaterThan20)




