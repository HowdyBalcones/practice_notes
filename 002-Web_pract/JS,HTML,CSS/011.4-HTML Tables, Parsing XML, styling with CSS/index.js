// console.log("Howdy Tablers")

// // let newRow = document.getElementById('new-Row');
// let tableR = document.createElement("td");
// let para = document.createElement("p");


//// This creates a list, notice the append child order ------------------

// let fragment = document.createDocumentFragment();
// let li = fragment

// .appendChild(document.createElement('section'))
// .appendChild(document.createElement('ul'))
// .appendChild(document.createElement('li'))
// li.textContent = 'now is THIS THING OFF?'

// document.body.appendChild(fragment)
// console.log(li)


//// Now lets try with a table ------------------------------------
//// This was a great excercise, should be followed up on with my own data and 
//// Variables


// let mountains = [
//   { name: "Monte Falco", height: 1658, place: "Parco Foreste Casentinesi" },
//   { name: "Monte Falterona", height: 1654, place: "Parco Foreste Casentinesi" },
//   { name: "Poggio Scali", height: 1520, place: "Parco Foreste Casentinesi" },
//   { name: "Pratomagno", height: 1592, place: "Parco Foreste Casentinesi" },
//   { name: "Monte Amiata", height: 1738, place: "Siena" }
// ];

// function generateTableHead(table, data){
// 	let thead = table.createTHead();
// 	let row = thead.insertRow();

// 	for (let key of data){
// 		let th = document.createElement('th');
// 		let text = document.createTextNode(key);
// 		th.appendChild(text);
// 		row.appendChild(th);
// 	}
// }

// function generateTable(table,data){
// 	for (let element of data){
// 		let row = table.insertRow();
// 		for (key in element) {
// 			let cell = row.insertCell();
// 			let text = document.createTextNode(element[key]);
// 			cell.appendChild(text);
// 		}
// 	}
// }



// let table = document.querySelector('table');
// let data = Object.keys(mountains[0]);

// generateTable(table,mountains);
// generateTableHead(table,data);

//------------------------------------------------------------------------------
// Filling arrays with stuff pt 1

// one method, but it fills the array with copies of index 0
let object1 = {
	"hello":"goodbye"
}

let rndmNum = Math.floor(Math.random()*100)+1;
// let filledArray = new Array(100).fill(object1)


// this method makes a distinct object at each index,
// instead of copies

// let filledArray = new Array(10).fill(null).map(()=>({'hello':'goodbye'}))


// this method makes a distinct object at each index, but uses a for loop
let filledArray = new Array(25);

for(let i=0;i<filledArray.length;i++){
	filledArray[i] = {'hello':'goodbye'}
}

filledArray[0].hello = 'adios'
console.log(filledArray)

//------------------------------------------------------------------------------

//Creating objects and placing them into arrays 

animal1 = new Animal(rndmNum,rndmNum,rndmNum,rndmNum);

class Animal {
	constructor(name, species, fixed, age){
		this.name = name
		this.species = species
		this.fixed = fixed
		this.age = age
	}

	animalArray(){
		let filledArray = new Array(10).fill(animal1)
	}
}

console.log(animal)

//------------------------------------------------------------------------------

// This was attempt 1 for our table


// let fragment = document.createDocumentFragment();
// let tr = fragment;

// document.body.appendChild(document.createElement('table'))
// .appendChild(document.createElement('thead'))
// .appendChild(document.createElement('tr'))
// // .appendChild(document.createElement('th'))

// tr.textContent = 'hello i am new'
// document.body.appendChild(fragment)


// para.innerHTML = "is this thing on mate";
// document.body.appendChild(para)
// console.log(para)




// function makeRow(){
// document.table.tbody.tr.appendChild(tableR);
// tableR.innerHTML = "is this row on"
// }

// const para = document.createElement("p");
// let para1 = document.createElement('p');

// para.innerText = "This is a paragraph.";
// para1.innerText = 'Is THIS thing on?';

// // Append to body:
// document.body.appendChild(para);
// document.body.appendChild(para1);