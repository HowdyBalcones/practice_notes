//Cheat Sheet
	//Data Types
	//Strings, Numbers, Booleans

	//Complex Data Types
	//

	//string methods
	//toUpperCase() - makes all characters in a string upper case
	//toLowerCase() - makes all characters in a string lower case
	//concat() - combines two strings together



	//array methods
	//indexOf()
	//filter() - filter(element, index, array)
	//slice()
	//push()
	//pop()
	//reduce() - 
	//map()
	//concat()
	//includes()
	//some()
	//every()

	//Ternary Statements

//Samples
//Arrays
let dwarves = ["Gordon", "Michael", "Gloinor", "Stumpy", "Talls", "Long Gears", "Bushy Brow", "Zannoying","Tingle","Dingle","Gimli","Anvil Chin"]
let numbers1=[12,10,2,16,78,95,23,67,353,112,8786,1,234,7345,-123,666,987]

//strings excercise
"This is a string"
let example = "This is a string stored in a variable";
example=example.toUpperCase().toLowerCase();

//string syntax
let str1 = "This Creates a string literal"
let str2 = String("This creates a string value and converts the contents into a string")
let str3 = new String("This would be a verbose way to make a new string") // it's also logging each character in the string

console.log(example)
console.log(str2, str3)
console.log(str3)

//array excercises------------------------------

let arrayExample = ["Item1", "Item2", "Item3"]
console.log(arrayExample)

//for each

arrayExample.forEach(output);

function output(item,index,array){
console.log(item,index)
}

//another example of how a for each loop is implemented

arrayExample.forEach(function(item,index,array){
	console.log(item+item+123,index)
})

//example 2 of for each loop 

//this would parse each string given into a number throughout the array
let arrayExample2 = ["2201790250","1701785318","1701782213"]
let dummyArray2 = []

arrayExample2.forEach(function(item,index,array){
	let parsed = parseInt(item,10)
	console.log(parsed)
	dummyArray2.push(parsed) //this pushes each parsed item into an empty array
})

console.log(dummyArray2)

//this makes a variable that contains a reduce function that is taking each item from the dummy array and
//adding it to the next item that array


let sumOfDummyArray2 = dummyArray2.reduce(function(passedIn, item){
	return passedIn+item

},0)

//this just calls the sum of all the items added together by the reduce method that was stored in a variable
console.log(sumOfDummyArray2)

// console.log(parsedExample2)


//array reduce() method
	//reduce() practice 1 ---

let sum = numbers1.reduce(function(passedIn, item){

return passedIn + item;

}, 0);

console.log("LOOOOG")
	//reduce practice 2 ---
let sum2 = numbers1.reduce(function(passedIn, item){
console.log(passedIn,item)
// return passedIn * item
if (item<20){
	return console.log("Smol Bean")

	}else{
	return console.log("Giant Friggin Weeb")
	}


}, 1);

//reduce() practice 3 --- I literally have no idea why this works

let first1 = dwarves.reduce(function(current,item){
console.log("comparing", current, "to", item)
return (current<item)?current:item; // ternary operator wooooO

},"\u0434") 

// so it is comparing the unicode values, whichever is less is carried forward and compared to the next

console.log(sum)
console.log(sum2)
console.log("First Movie is", first1)

//concat() practice 1 ---
let a1 = [1,2,3,4]
let b1 = [5,6,7,8,9,10]

//these are some ways to loop through these and add them together
//examples
// for()
// for( in )
// a1.forEach()

let c1 = a1.concat(b1)
let d1 = [].concat(a1,b1,dwarves).sort();

console.log("c1",c1);
console.log("d1",d1);

//includes() practice 1 ---

let name1 = "Peter Dinklage"
let name2 = "Kenny Baker"
let name3 = "Happy"
let name4 = "Zannoying"
let name5 = "Gordon"

let hasPeter = dwarves.includes(name5, name4); //should return true or false

console.log("Contains Peter", hasPeter);

//some() practice 1 ---

let keyword1 = "Chin"
let keyword2 = "Gears"
let keyword3 = "Dingle"

let testSome = dwarves.some(function(title,index){
	console.log("Some Practice",index,title)
	return title.indexOf(keyword3) > -1 ; // is keywordx found within the title, using indexOf to search
	//each title for the passed in keyword. 

});


//functions examples, excercises----------------------------------------


//explaining parameters and passing them into functions
//the parameters are place holders for things outside the function to be called into the function

//Could also be understood as variables that are placed into the base function, that have
//more specific data passed into them when the function is called later

let burger1 = "mmm"
let burger2 = "ahh"
let burger3 = "gross"

let meatyBurgersEaten = [burger1, burger2, burger1, burger3]
function exampleFunction(burgs){
	console.log(burgs)
}

exampleFunction(meatyBurgersEaten);

//understanding callback functions


let nameLengths = dwarves.map(function(item,index,array){
	
	// This also works
	// len = item.length;
	// return len
	return item.length;
})

console.log(nameLengths);



//object examples and excercises -------------------------------------------

let object1 = {
	name: "Dangit Bobby",
	show: "King of the Hill",
	isGood: true,
	timesWatched: 1000

}


//basic function
function stringExample(){
	console.log(example.toUpperCase())
}
stringExample();

	//callback functions - a function to execute for each element in the array
// arrayExample.forEach(function(item,index,array){
// 	return item.length
// 	console.log(index, item)
// }


//conditional examples and excercises --------------------------------------



function ifThenExample1(){
	if (example.length > 100){
		console.log("Dang big ol string man i tell u what")
	} else {
		console.log("dang city boy string i tell u what")
	}
}

ifThenExample1();


//Ternary Operators

// (logic to test against)? if so run this : if else run this ;  --- Abbreviated ()?:;
let first = true 
let last = false 
let imOld = 27
let isAlive = false

first==last?console.log("Nope"):console.log("Yep");

first==last?console.log("ABSOlutely"):(imOld)?console.log("BaadROBOT"):console.log("yep");











