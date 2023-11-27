console.log('howdy howdy howdy')

//// Examples from MDN ---------------------------------------------------------- 
// the ${} doesnt work for some reason
// if you use a template literal it uses the back tick, underneath tilde

let buttonA = document.querySelector('#button-A');
let headingA = document.querySelector('#heading-A');

buttonA.onclick = () => {
	const name = prompt('What is your poison trailhand?');
	alert(`We have ${name}, that will be a dollar`);
	headingA.textContent = `A tall stiff glass of ${name}`
}

let myName;
let myAge;

const num1 = 15;
const num2 = 65.5426;

console.log(typeof num1);
console.log(typeof num2);

let newNum2 = num2.toFixed(2)
console.log(newNum2);

// possible to declare something as a number with the Number() method

let num3 = '453';
let newNum3 = Number(num3) + 45
console.log(newNum3)

//// Going over strings again ----------------------------------------------------------

// Review of Template Literals 
// The main difference is that you can store variables inside these strings more easily


let greeting = 'Hello, ';
let greeting2 = 'how are you?'

let fullGreet = `${greeting}${greeting2}`;
console.log(fullGreet)

const song = 'Fight the Youth';
const score = 9;
const highestScore = 10;
const output = `I like the song ${song}. I gave it a score of ${(score / highestScore) * 100} %`

console.log(output);

// Template literals also respect line breaks wow 

const output2 = `I like the song etc etc 
as well as the song etc etc etc 
and even the song quadEtc.`

console.log(output2)

// Review of string methods(), good to be back on the MDN ----------------------------------------------------------

const browType = 'mono'

console.log(browType.length)

// The string has an index like an array

console.log(browType[0])
// This gets the last character from the array, a way to access the array from behind

console.log([browType.length-1])
// This searches a given string for a specific subString

// includes()

if (browType.includes('ono')){
	console.log('Yoko?')
} else {
	console.log('Ringo!')
}

// The startsWith() and endsWith() methods, checks for subString from beginning or end of a given string


if (browType.startsWith('mo')){
	console.log('wat')
} else {
	console.log('Testing')
}

if (browType.endsWith('ono')){
	console.log('Ringo!')
} else {
	console.log('Octopuses Garden!')
}

// The indexOf() method takes two parameters, the substring you're searching for
// and the optional parameter that sets the starting point of the search

const tagLine = 'Hello I am a space explorer from the Terra system, do you have Hamburger?'

console.log(tagLine.indexOf("Hamburger"));


// The slice() string method can be passed the index from which to start, and the index to stop extracting


function pullWords(){
	let pos1 = tagLine.indexOf('do');
	let pos2 = tagLine.indexOf('er?')

	let Length = tagLine.length
	console.log(tagLine.slice(0,Length-10));
	console.log(tagLine.slice(7,11));
	console.log(tagLine.slice(12,28));
	console.log(tagLine.slice(pos1,pos2-1))
}

pullWords();

// The toLowerCase() and toUpperCase(), converts all characters to either or 

let spongeSpeak = 'HElLo mR KrABs wHatS cOOkIn?';

console.log(spongeSpeak.toUpperCase());
console.log(spongeSpeak.toLowerCase());

// The replace() method takes the string to replace, and the replacing string


let updatedTagLine = tagLine.replace('Hamburger','Cheeseburger');
console.log(updatedTagLine);


//// A useful MDN excercise ----------------------------------------------------------

// const list = document.querySelector('.output ul');
// list.innerHTML = '';
// const stations = ['MAN675847583748sjt567654;Manchester Piccadilly',
//                   'GNF576746573fhdg4737dh4;Greenfield',
//                   'LIV5hg65hd737456236dch46dg4;Liverpool Lime Street',
//                   'SYB4f65hf75f736463;Stalybridge',
//                   'HUD5767ghtyfyr4536dh45dg45dg3;Huddersfield'];

// for (const station of stations) {
//   // write your code just below here
//   startCode = station.slice(0,3); //this takes the first three letter code and stores into a var
//   semiColon = station.indexOf(';')  // this takes the position of the semicolon, stores it
//   stationName = station.slice(semiColon+1); //this returns everything after the semicolon as a new string, stores it
//   finalStation = `${startCode}: ${stationName}` //this stores creates a template literal, takes the previous stored variables, concatenates them and places a colon between.

//   const result = finalStation; // this is a variable to set the finalStation to

//   const listItem = document.createElement('li');
//   listItem.textContent = result;
//   list.appendChild(listItem);
// }


// Review of string methods(), good to be back on the MDN ----------------------------------------------------------

let array1 = ['Pony','Dog','Lama','Hog','Falcon','Trout','Bear','Deer'];
let array2 = [12,23,44,55,123,67,53,99,100,29];
let array3 = [1,2,3,[4,5,6]];


console.log(array1.length);
array1[0] = 'Barracuda'
console.log(array1[0]);
console.log(array3[3][0]); // interesting, accessing an array within array
// What use does this data structure have ?

function indexOfEach(){
for(let i = 0;i<array1.length;i++){
let animals = array1[i]
console.log(array1.indexOf(animals))
}
}

console.log(array1.indexOf('Lama'))
indexOfEach();

// The push() method for an array, a question is can this be applied to a string?

let array1New = array1.push('Whale','Dolphin');
console.log(array1New)

// The answer is: Nope.
// spongeSpeak.push('Mr. Krabs?')
// console.log(spongeSpeak)

// The push method alters the called array, it adds the items to the end of the array

// The unshift() method adds item to the start of an array

array1.unshift('Pelican','Sparrow')

console.log(array1)

// The pop() method removes the last item from an array, returns the removed item.
// You can store this removed item in a variable.

let popped = array1.pop();
console.log(array1)
console.log(popped)

// You can remove the first item in an array with the shift() method, returns removed item
// Can be stored in a variable as it returns the removed item

let shifted = array1.shift();
console.log(array1);
console.log(shifted);

// The splice() method can, using an index value as the parameters,
// remove from the starting index to the ending index. The removed items are 
// returned and can be stored within a variable.

let spliced = array1.splice(0,3);
console.log(array1);
console.log(spliced)

// Accessing every item within an array, for...of loops

for (let animal of array1){
	console.log(animal)
} // this returns each item from within the array in a variable named animal

// The map() method, changing each item in an array, then placing it into a new array
// Aside, we should review the Professors videos on callback functions and apply this practice there

function double(number){
	return number*2;
}

let doubledArray2 = array2.map(double);
console.log(doubledArray2)

// The filter() method runs a test against an array and returns a new array with 
// the matching items

function howLong(animal){
	return array1.length > 4;
}

let array1HowLong = array1.filter(howLong)
console.log(array1HowLong);














