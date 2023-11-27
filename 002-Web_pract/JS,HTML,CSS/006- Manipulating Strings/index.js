
// //Using the splice() on arrays
// // splice(starting index, # of items to replace, optionally 
// // the items that are replacing the removed items.)

// let characters = ["Luke","Leia","Han","Chewie"];
// console.log(characters)

// characters.splice(0,1, "Rey")
// console.log(characters)

// characters.splice(1,2,"Kylo")
// console.log(characters)

// characters.splice(1,1,"C3-PO", "R2D2")
// console.log(characters)

// characters.splice(1,2)
// console.log(characters)

// //sorting through arrays

// characters.push("BB8")
// characters.push("Obi-Wan")
// console.log(characters)

// characters.reverse(); //reverses array index values
// console.log(characters)
// characters.sort(); //sorts an array by alphabetical order
// console.log(characters)

// //the above methods can be applied in opposite order to get 
// //a reversed array alphabetically organized

// //Searching through an array to find something inside of it 

// //indexOf() searches from the beginning of an array to the end
// //lastIndexOf() searches from the end of an array to the beginning
// //Search an array for a given item, returns index value



// let position = characters.indexOf("Chewie")
// console.log(position)
// position = characters.lastIndexOf("Rey")
// console.log(position)

// //basic array methods

// console.log(characters)
// console.log(characters.length)
// console.log(characters[characters.length-1]) // this references the length of the array

// characters.push("Anakin") //adds to end of array
// console.log(characters)

// characters.pop() // removes the last item of an array
// console.log(characters)

// characters.unshift("Darth Maul") //picks up array stack and adds input to beginning of array
// characters.unshift("Generic Sith Goon")
// console.log(characters)

// characters.shift() // removes the first item in an array stack
// characters.shift()
// console.log(characters)

// //Some string and Array Concatenation


// let name = "Camden"
// let id = 242424
// let alive = true
// let fiveDs;

// console.log(name)

// //concatenation, or adding strings to one another
// name = "Ricky"
// console.log(name)
// name = name+" Bobby"
// console.log(name)


// //concatenating items from an array

// fiveDs = ["Dodge","Duck","Dip","Dive","Dodge"]
// console.log(fiveDs[4]+ " " +fiveDs[2])

// //Working with Objects - Basics
// // {type:"Data","SecondData"}



// let dog = {
// 	name:"Woody", 
// 	type:"dog"
// }


// let cat = {
// 	name:"Doug",
// 	type:"cat"
// }

// let petNames = ["Woody", "Doug"]
// console.log(petNames)

// let pets = dog.name + " " + cat.name
// console.log(pets)

// let petArr = [dog,cat]
// console.log(petArr)

// petArr.push({name:"Roxie",type:"giraffe"}) //adding an object to the array

// console.log(petArr[petArr.length-2]) //return specific object in array

// //adding a type to an object class
// cat.age = 2
// dog["age"] = 9 //this is called an object literal, need to research more


// console.log(dog,cat)


//Mini test - Construct array of Item #'s as strings
//create variable for UPC constants
//concatenate the two, return in new array
//make an object from an item #
//success

// let advilRegArr = ["01786","01790","01791","11794","21794"]
// let advilRegArr2 = [];
// let upcConstants = "655708"

// // let "01786" = {
// // name:"Advil Regular"
// // packType:"Dispenser"
// // count:50
// // }

// function addUpcConstants(){
// 	for (let i = 0;i<advilRegArr.length;i++)
// 		advilRegArr2.push(upcConstants+advilRegArr[i])
// 	console.log(advilRegArr2)
// }

// addUpcConstants()


//big test - create check digit >:(
//using charAt(), check if 
//return each odd index in a string, return each even index in a string

// let string1 = "65570821794"
// let stringArrEven = [];
// let stringArrOdd = [];

// // console.log(string1)

// // console.log(string1[3])

// // console.log(string1.charAt(0))

// //now to add the even and odd piles together somehow

// function checkString(){
// 	for (let i = 0;i<string1.length;i++)
// 	{ let stringNum = string1[i]
// if (stringNum%2==0){ //this tests if the value in the array is even or odd
// stringArrEven.push(stringNum)} else {
// 	stringArrOdd.push(stringNum)
// }

// }

// }



// checkString()
// console.log(stringArrEven)
// console.log(stringArrOdd)


let string1 = "65570821794"
let stringArrEven = []
let stringArrOdd = []
let evenConstants = [1,3,5,7,9]
let oddConstants = [0,2,4,6,8,10]


function checkStringEven(){

	for (let i = 0;i<5;i++)

	stringArrEven.push(string1[evenConstants[i]])
}

function checkStringOdd(){
	for (let i = 0;i<6;i++)
	stringArrOdd.push(string1[oddConstants[i]])
}

//attempting to add the elements of the two arrays
//trying to use reduce() but coders insist on being cryptic 
//with every instruction apparently

console.log(stringArrEven.reduce(addStringBucketEven,1))

function addStringBucketEven(total,num){
	return total+num
}


checkStringEven()
checkStringOdd()
addStringBucketEven()
console.log(stringArrEven)
console.log(stringArrOdd)
















