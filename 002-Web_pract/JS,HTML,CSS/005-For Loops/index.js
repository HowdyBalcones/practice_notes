//document.getElementById("count-el").innerText = 9999999

//Some way to store the count
//vairables to store count in

//let count=5+12
//console.log(count)

//let myAge=27
//console.log(myAge)

// let firstBatch = 5
// let secondBatch = 7
// let count = firstBatch + secondBatch

// console.log(count)

// let myAge=27
// let humanDogRatio=7
// let myDogAge=humanDogRatio*myAge

// console.log(myDogAge)


//count+1
// let count = 3
// let count = 5
// count=count+1
// console.log(count)

// let bonusPoints=50
// bonusPoints=bonusPoints+50
// console.log(bonusPoints)
// bonusPoints=bonusPoints-75
// console.log(bonusPoints)
// bonusPoints=bonusPoints+45
// console.log(bonusPoints)

//initialize the count as 0
//listen for clicks on the increment button
// increment the count variable when the button is clicked
//change the count-el in the HTML to relect the new count

// function increment() {
// 	console.log("The button was clicked")
// }

// set up race

// function countdown(){
// console.log(5)
// console.log(4)
// console.log(3)
// console.log(2)
// console.log(1)
// }

// countdown()

// // go!
// // Players are running the race
// // race is finished

// // Get ready for the new race
// countdown()

//How to avoid repetition

// // create function that logs out the number 42 to the console
// //call or invoke the function

// function dogBone() {
// 	console.log(42)
// }

// dogBone()

// let lap1 = 34
// let lap2 = 33
// let lap3 = 36

// //create function that logs out the sum of all the lap times

// // function blackAdder(){
// // 	console.log(lap1+lap2+lap3)
// // }
// // blackAdder()

// //alternatively
// function blackAdder(){
// 	let totalTime = lap1 + lap2 + lap3
// 	console.log(totalTime)
// }
// blackAdder()


//document.getElementById("count").innerText = 5

// let count=0
// let countEl= document.getElementById("count-el") // this is called passign in a function
// console.log(countEl)

// function increment() {
// 	count = count + 1
// 	countEl.innerText = count
// 	console.log(count)
// }

//initialize count var as 0
// grab count-el and place into var countEl and log it after
//create increment function, attach countEl to inner text, set it equal to count
//log within the function

// let count=0
// console.log(count)

// let countEl= document.getElementById("count-el")
// console.log(countEl)

// let saveBtn= document.getElementById("save-btn")

// function increment(){
// 	count=count+1
// 	countEl.innerText = count 
// 	console.log(count)
// 	saveBtn.innerTxt = "Save"
// }

// function save(){
// 	saveBtn.innerText = "Saved"
// 	console.log("Saved" + " " + count)
// 	count = 0
// }

// let username = "per"


// let message = "You have tree new notifications"


// // console.log(message + " " + username + "!")

// let messageToUser = message+ " " + username + "!"
// console.log(messageToUser)

// let name = "Camden -"
// let greeting = " Hi World, my name is Slim Shady"
// let myGreeting = name+greeting
// console.log(myGreeting)

// let points = 4
// let bonusPoints = "10"

// let totalPoints = points+bonusPoints
// console.log(totalPoints)

// console.log(4+5)
// console.log("2"+"4")
// console.log("5"+1)
// console.log(100+"100")

// // Sending and Rendering message to DOM
// let welcomeEl = document.getElementById("welcome-el")
// let name = "Camden Bailey"
// let greeting = "Hi my name is "

// welcomeEl.innerText = greeting+name

// welcomeEl.innerText = welcomeEl.innerText + " :^)"
// //same as 
// welcomeEl.innerText += " :^)"


// The Counter Program 
// let count=0
// console.log(count)

// let countEl= document.getElementById("count-el")
// console.log(countEl)

// let saveEl = document.getElementById("save-el")

// let saveBtn= document.getElementById("save-btn")

// function increment(){
// 	count+= 1
// 	countEl.textContent = count 
// }

// function save(){
// 	saveNum = count + " - "
// 	saveEl.textContent += saveNum
// 	countEl.textContent = 0
// 	count = 0
// }

// let featuredPosts = [
// 	"Check out my netflix clone!",
// 	"Here's the code for my projects.",
// 	"I've just relaunched my portfolio"
// 	]

// let experience = [
// 	"I am a Graphic Designer and Painter", 
// 	"I graduated Cornish College of the Arts with a double major in Fine Art & Design", 
// 	"I can pat my head and rub my tummy as a result of my experiences there"
// 	]

// console.log(featuredPosts[0])
// console.log(featuredPosts[1])
// console.log(featuredPosts[2])

// let array3 = [
// "Sometimes I eat pizza", 123, false
// 	]
// console.log(array3[0])
// console.log(array3[1])
// console.log(array3[2])

// let cards = [5, 11, 12]

// cards.push(2)

// console.log(cards)

// let messages = [
// 	"Hey, how's it going?",
// 	"I'm great, thank you! How about you?",
// 	"All good. Been working on my portfolio lately."
// 	]

// let newMessage = "Same here!"

// messages.push(newMessage)
// console.log(messages)

// // how to remove the last item from an array?
// messages.splice(3, 1, cards)

// console.log(messages)

// for (let count = 10; count < 21; count += 1) {
// console.log(count)

// }
// for (let count = 10; count <= 100; count += 10) {

// 	console.log(count)
// }

// DRY - Dont Repeat Yourself

// let messages = [
// 	"Hey, how's it going?",
// 	"I'm great, thank you! How about you?",
// 	"All good. Been working on my portfolio lately.",
// 	"Same here!",
// 	"Great to hear",
// 	"Occasionally I code poorly"
// 	]

// for (i = 0; i < messages.length; i += 1 ){
// 	console.log(messages[i])
// }

// let sentence = ["Hello", "my", "name", "is", "Slim", "Shady"]
// let greetingEl = document.getElementById("greeting-el")

// for (i = 0; i < sentence.length; i += 1){
// greetingEl.textContent += sentence[i] + " "
// 	console.log(sentence[i])
// }

// Beginning of Randomization 

// let player1Time = 102
// let player2Time = 101
// let randomNumber = Math.floor( Math.random() * 7);


// //cmd+d - ctrl+d 

// function getFastestRaceTime(){
// 	if (player1Time < player2Time) {
// 		return player1Time
// 	} else if (player1Time > player2Time) {
// 		return  player2Time
// 	} else {
// 		return player1Time
// 	}
// }
// let fastestRace = getFastestRaceTime()

// console.log(fastestRace);

// function totalRaceTime(){
// 	let raceTime = player1Time+player2Time;
// 	return raceTime
// }

// let totalTime = totalRaceTime();
// console.log(totalTime)

// console.log(randomNumber)


// function rollDice(){
// return randomNumber();
// }

// function 
// console.log(randomNumber);


// Logical Operators Beginning
// If there are multiple states that need to be checked
// let hasCompletedCourse = true
// let givesCertificate = true

// if (hasCompletedCourse === true && givesCertificate === true) {
// 	generateCertificate()
// }

// function generateCertificate() {
// 	console.log("Generating certificate...")
// }
// // //the above can also be accomplished by nesting if statements
// // generally considered bad practice

// // if (hasCompletedCourse === true){
// // 	if (givesCertificate === true){
// // 		generateCertificate()
// // 	}
// // }

// let hasSolvedChallenge = false
// let hasHintsLeft = false

// if (hasSolvedChallenge === false && hasHintsLeft === false){
// 	showSolution();
// }

// function showSolution(){
// 	console.log("Showing the solution...")
// }

// Examining the or operator

// let likesDocumentaries = false
// let likesStartups = false

// if (likesDocumentaries === true || likesStartups === true){
// 	recommendMovie();
// }

// function recommendMovie(){
// 	console.log("Hey check out Netflix, so many things and not shit to watch!")
// }

// Beginning objects
// store key-value pairs
//Functions inside objects are called Methods

// let course = {
// 	title: "Learn CSS Grid for Free",
// 	lessons: 16,
// 	creator: "Per Harald Borgen",
// 	length: 63,
// 	level: 2,
// 	isFree: true,
// 	tags:["html","CSS"]
// }

// console.log(course.isFree, course.level, course.length)

// let airCastle = {
// 	available: true,
// 	title: "Sir Pockingtons Estately Manor",
// 	fee: 1000000,
// 	wings: ["North", "South", "East", "West"]

// }

// console.log(airCastle.available,airCastle.title)


// // Practice 1 - Objects & Functions

// let person = {
// 	name: "Camden",
// 	age: 27,
// 	country: "America",

// }

// function logData(){
// 	console.log(person.name + " " + "is" + " " +  person.age + " " + "years old and lives in" + " " + person.country)
// }

// logData()


// // Practice 2 - Conditional Statements

// let age = 17
// let cost = 5.50

// if (age < 6) {
// cost = 0
// } else if (age >= 6 && age <= 17){
// 	cost = 2.50
// } else if (age >= 17 && age <= 26){
// 	cost = 3.50
// } else if (age >= 27 && age <= 66){
// 	cost = 5.50
// } else if (age > 66){
// 	cost = 3.50
// }

// console.log(cost)

// // Practice 3 - For Loops & Conditional Statements

// let largeCountries = ["China", "India", "USA", "Indonesia", "Pakistan"]

// for (i = 0; i < largeCountries.length; i++)

// console.log(largeCountries[i])

// // Practice 4 - Manipulating Arrays

// let largeCountries = ["Tuvalu", "India", "USA", "Indonesia", "Monaco"]

// largeCountries.pop();
// largeCountries.shift();
// largeCountries.push("Pakistan")
// largeCountries.unshift("China")
// console.log(largeCountries)

// // Practice 5 - Logical Operators

// let dayOfMonth = 13
// let weekDay = "Friday"

// if (dayOfMonth === 13 && weekDay === "Friday"){
// 	console.log("Dang Spoopy")
// }

// // Practice 6 - Random and Arrays

// let hands = ["rock", "paper", "scissors"]

// function getHand(){
// 	let randomHand = Math.floor(Math.random()*hands.length)
// 	let pickHand = hands[randomHand]
// 	console.log(pickHand)
// }

// getHand()

// // Practice 7 - Arrays, Loops, HTML

// let fruit = ["Apple","Orange","Apple","Apple","Orange"]
// let appleShelf = document.getElementById("apple-shelf")
// let orangeShelf = document.getElementById("orange-shelf")

// function fruitOrganizer(){
// 	for (let i = 0; i<fruit.length;i++){
// 	if (fruit[i] === "Apple"){
// 		appleShelf.textContent += "Apple, "
// 	} else if (fruit[i] === "Orange"){
// 		orangeShelf.textContent += "Orange, "
// 	}
// }
// }

// fruitOrganizer()





