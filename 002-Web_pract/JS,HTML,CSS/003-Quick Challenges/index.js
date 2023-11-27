
// Excercise 1
// let firstName = "Camden"
// let lastName = "Bailey"
// let fullName = firstName+ " " +lastName
// console.log(fullName)

// Excercise 2
// let name = "Linda"
// let greeting = "Hi there"

// function welcome(){
// 	let welcomeMsg = greeting + ", " + name + "!"
// 	console.log(welcomeMsg)
// }

// welcome()

// // Excercise 3
// let myPoints = 3
// console.log(myPoints)

// function add3Points() {
// 	myPoints += 3
// 	console.log(myPoints)
// }
// //decrement this way
// function remove1Point(){
// 	myPoints -= 1
// 	console.log(myPoints)
// }

// add3Points()
// add3Points()
// add3Points()
// remove1Point()
// remove1Point()

// // Excercise 4
// console.log("2" +2) // 22
// console.log(11 + 7) // 18
// console.log(6 + "5") // 65
// console.log("My Points: " + 5 + 9) // My Points: 14 - correction - 59
// console.log(2 + 2) // 4
// console.log( "11" + "14") // 1114

// // Excercise 5

// let errorParagraph = document.getElementById("error")
// console.log(errorParagraph)
// function purchase() {
// 	errorParagraph.textContent = "Something went wrong, please try again."
// }

// Excercise 6
let num1 = 8
let num2 = 2
let sumEl = document.getElementById("sum-el")
document.getElementById("num1-el").textContent = num1
document.getElementById("num2-el").textContent = num2

function add(){
console.log(num1+num2)
let result = num1+num2
sumEl.textContent = "Sum:" + result
}
function subtract(){
console.log(num1-num2)
let result = num1-num2
sumEl.textContent = "Sum: " + result
}
function multiply(){
console.log(num1*num2)
let result = num1*num2
sumEl.textContent = "Sum: " + result
}
function divide(){
console.log(num1/num2)
let result = num1/num2
sumEl.textContent = "Sum: " + result
}






