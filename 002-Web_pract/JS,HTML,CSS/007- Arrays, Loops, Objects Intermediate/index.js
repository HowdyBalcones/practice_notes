// // Arrays & Objects

// let dog = {
// 	name:"Bob",
// 	type:"dog"
// }
// let cat = {
// 	name:"Woody",
// 	type:"cat"
// }

// let petNames = ["Woody", "Bob"]
// console.log(petNames)
// let petLogs = [dog, cat]
// console.log(petLogs)

// petLogs.push({name:"Dingo", type:"Hippo"})
// console.log(petLogs)

// cat.age =2
// console.log(cat) //adds a category to an object
// console.log(petLogs) //the array is updated by the updated var

// petLogs[0].age = 14
// petLogs[2].age = 16

// console.log(petLogs)
// console.log(dog, cat) // the object will update if changed through the array


// // Loops Basics

// let names = ["Danny Brown","Tupac","Biggie Smalls", "Mos Def", "Bambu", "Fife Dog"];
// let numNames = names.length;

// //initialize; test; increment
// //as i know it

// // function starting(){
// // 	for (let i === 0;i<numNames;i++);
// // }

// //what Steve Griffith is saying is the case 

// for(let i =0;i<numNames;i++){
// 	console.log(names[i])

// }

// //decrementing through an array

// for(let i =numNames-1;i>=0;i--){
// 	console.log(names[i])

// }

// // For..in loops

// let monsters = {
// 	Canada:"Sasquatch",
// 	Nepal:"Yeti",
// 	Scotland:"Loch Ness Monster"
// 	}

// let people = ["Dave","Buzz","Gerald"] 

// 	console.log(monsters.length) // pulls undefined, objects dont have a length


// // for in object
// 	for(let prop in monsters ){
// 		// console.log(prop)
// 		// console.log(monsters[prop])
// 		console.log("In", prop, "we have the", monsters[prop]);
// 	}

// // for in array

// 	for (let prop in people){
// 		console.log("In", prop, "we have the", people[prop]);
// 	}


// //While loops

// // //while(condition){
// // 	statements
// // }

// // do {
// // 	statements
// // }while(condition)

// let total = 0;

// // while(total<30){
// // 	total += Math.floor(Math.random()*5);
// // 	console.log(total);
// // }

// do {

// 	total += Math.floor(Math.random()*5);
// 	console.log(total);

// } while(total<30)


// //Function Basics

let beer_cost = 6.45
let burger_cost = 5.00
let pop_cost = 3.00

// users money

let account_balance = 30

//drink beer


//eat burger


//drink soda, not pop


// this function checks the account to see if the amt is available to withdraw from the total balance
function checkBalance(amt){

	if(account_balance - amt >= 0){ //this checks if the account balance minus the purchase amt is greater than 0

console.log("You have purchased something") //message that a purchase has occurred 

return true; //returns true if there are enough funds in the account

	}else{

console.log("Insufficient Funds")
return false;
	}
}

//this function withdraws the cost of a beer from the account if there is enough cash in the account, passing the cost into amt in checkBalance
function drinkBeer(){
if(checkBalance(beer_cost)){

	account_balance=account_balance-beer_cost;
	console.log("Enjoy Your Beer")
}
console.log("\tBalance:",account_balance.toFixed(2));
}

//this function withdraws the cost of a burger from the account if there are the proper funds
function eatBurger(){
if(checkBalance(burger_cost)){

	account_balance=account_balance - burger_cost
console.log("MEAT BUNS AMERICAN STYLE")
}
console.log("\tBalance:",account_balance.toFixed(2));
}

//this function withdraws the cost of a soda from the account if there are the proper funds
function drinkSODA(){
if(checkBalance(pop_cost)){

	account_balance=account_balance - pop_cost
console.log("Cold & Sugary, just like my EX Wife")
}
console.log("\tBalance:",account_balance.toFixed(2));
}

function eatOut(){
	drinkBeer();drinkSODA();eatBurger();
}




//passing variables into functions

let mealList = [drinkBeer,drinkBeer,drinkSODA]

function visitCarnival(mList){

for (let i =0;i<mList.length; i++){

	mList[i](); // this is key, it calls the functions drinkSoda, eatBurger, etc from an array, in this case mealList.
	// notice the parentheses after the array call, this places them onto each item from the array, invoking the functions

}
}

visitCarnival(mealList);
// the above line is referring to the function, the parameters are passed into the function in order
























