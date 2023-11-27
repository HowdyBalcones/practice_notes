

let cards = [] //array
let sum = 0
let hasBlackJack = false
let isAlive = false
let msg = ""
let messageEl = document.getElementById("message-el")
let sumEl = document.getElementById("sum-el")
let cardsEl = document.getElementById("cards-el")
let playerEl = document.getElementById("player-el")

let player = { //object
	name: "P1",
 	chips: 145,
 	sayHello: function() {
 		console.log("Howdy Partna")
 	}
}
player.sayHello()
playerEl.textContent = player.name + ": $" + player.chips

console.log(cards)

function startGame(){
	isAlive = true
	let firstCard = getRandomCard();
	let secondCard = getRandomCard();
	cards = [firstCard,secondCard]
	sum = firstCard+secondCard
	renderGame()
}

function getRandomCard(){
let randomCard = Math.floor(Math.random()*13)+1;


if (randomCard > 10){
	return 10
} else if (randomCard === 1){
	return 11
} else {
	return randomCard
}

}

function renderGame(){
	//render out firstCard and secondCard
	cardsEl.textContent = "Cards: "

	for (i = 0; i < cards.length; i++) {
		cardsEl.textContent += cards[i] + " "
	}
// render out all cards in array ^^^

	if (sum <= 20) {
		msg = "Do you want to draw a new card?"

	} else if (sum === 21) {
		hasBlackJack = true
		msg = "Yippee, Still Broke!"

	} else {
		msg = "LOL, Game OVER!"
			isAlive = false
	}
messageEl.textContent = msg 
sumEl.textContent = "Sum: " + sum 

}

function newCard(){

if (isAlive === true && sum <= 21){

	let card = getRandomCard();
sum += card
cards.push(card)
console.log(cards)
renderGame()
}
// let card = getRandomCard();
// sum += card
// cards.push(card)
// console.log(cards)
// renderGame()

}

//a functional attempt at calling a new card into existence

// function newCard(){

// sum = firstCard + secondCard + thirdCard
// cardsEl.textContent =  "Cards:" + " " + firstCard + " " + secondCard + " " + thirdCard
// sumEl.textContent = "Sum: " + sum
// console.log(sum)

// }


// another way to grab something from DOM
// Query selectors
// ex: let sumEl = document.querySelector("#sum-el")
// notice the inclusion of the ID tag



// console.log(hasBlackJack)
// console.log(isAlive)

// console.log(4 === 3) // false
// console.log(5 > 2) // true
// console.log(12 > 12) // false
// console.log(3 < 0) // false
// console.log(3 >= 3) // true
// console.log(11 <= 11) // true
// console.log(3 <= 2) // false