console.log("Howdy Self")
// basic fetching
// using jsonplaceholder for the data
// Remember that fetch returns a promise

// HTTP Status Codes http://www.restapitutorial.com/httpstatuscodes.html
// to test with NODE need to install the node-fetch package
// npm install node-fetch
// let fetch = require("node-fetch");

// Promises - wat the heck ---------------------------------------------------------------------------------------------------------------

// //get the details from a random user
// let root = "http://jsonplaceholder.typicode.com";
// let id = Math.floor(math.random()*20) + 1; //id 1-20
// let uri = root + "/users/" + id;

// console.log("Fetch: " + id);
// //any user id higher than 10 will generate a 404 error

// fetch( uri )
// 	.then( )
// 	.then( )
// 	.catch( )

// we'll do this later its a bit too much atm

// Callback functions ----------------------------------------------------------------------------------------------------------------
// built in callback functions
// setTimeout, Arr.forEach, geolocation.getCurrentPosition
// make your own callback functions

// let names = ["Bob", "Joey", "Lucy", "Ida"]
// names.forEach(hello); // this function will be called once forEach item in the array

// navigator.geolocation.getCurrentPosition(gotPosition, positionError, {});

// function gotPosition(position){

// }
// function positionError(error){

// }


// setTimeout( hello, 2000, names)

// function doThing(other) {
// 	let x = 7;
// 	let name = "Steve";
// 	other(name); // this is a function inside a function, other is a parameter given to the parent function doThing
// }


// function hello(nm, idx, arr){ //this is a function that makes a simple console log
// 	console.log("Hello", nm);
// }

// doThing(hello) // here we call the hello function from within the doThing function, passing in the hello function as if it were other

// // i guess parameters are primarily used for passing variables between functions throughout a program

// Working in P5js - Coding Train ---------------------------------------------------------------------------------------------------------------

// let ball = { // an object is a set of variables in a container
//   x: 300,
//   y: 200,
//   xspeed: 4,
//   yspeed: -3
// }

// function setup() {
//   createCanvas(600, 400);
//     background(0);
// }

// function draw() {

//   display();
//   bounce();
//   moveIt();
// }

// function moveIt() {
//   ball.x += ball.xspeed;
//   ball.y += ball.yspeed;
// }

// function bounce() {
//     if(ball.x > width || ball.x < 0){
//     ball.xspeed = ball.xspeed * -1;
//   }
//   if (ball.y > height || ball.y < 0){ 
//   ball.yspeed = ball.yspeed * -1;
//   }
// }

// function display() {
//   stroke(random(255),random(255),random(100),100);
//   strokeWeight(random(10));
//   noFill();
//   ellipse(ball.x,ball.y,random(30),24);
// }

// // Working in P5js - Coding Train ---------------------------------------------------------------------------------------------------------------
//// Making faces of dubious quality, understanding parameters in use

// function setup() {
//   createCanvas(400, 400);
// }

// function draw() {
//   background(220);
//   face();
//   eyes();
//   mouth();
//   nose();
// }

// function face(){
//   fill(255);
//   ellipse(150,100,200,200)
// }


// function eyes(){
//   fill(25)
//   ellipseMode(CENTER);
//   ellipse(100,100,35,45);
//   ellipse(200,100,35,45);
// }

// function mouth(){
//   line(100,160,200,160)
// }

// function nose(){
//   fill(100)
//   triangle(135,140,150,100,165,140)
// }

// Making the face change randomly with parameters -----------------------------


// function setup() {
//   createCanvas(400, 400);
// }

// function draw() {
//   background(220);
//   face(150,100,200);
//   eyes(random(45),random(45),random(35));
//   mouth();
//   nose(random(100),150);
// }

// function face(x,y,size){
//   fill(255);
//   ellipse(x,y,size,200)
// }


// function eyes(sizeL, sizeR, color){
//   fill(25)
//   ellipseMode(CENTER);
//   ellipse(100,100,sizeL,sizeR);
//   ellipse(200,100,sizeL,sizeR);
// }

// function mouth(){
//   line(100,160,200,160)
// }

// function nose(leftNos,rightNos){
//   fill(100)
//   triangle(leftNos,140,150,100,rightNos,140)
// }

// // Some practice with classes and functions -----------------------------

// // What is encapsulation in OOP? 
// // What is OOP fundamentally?
// // What is a class - Blueprint, schematic

// class bubble {
// 	// everything it means to be a bubble inside your program
// 	// increases modularity, allows a collection of data to be placed into an object and throughout multiple functions
// }

// bubble = new bubble() // if a class is the cookie cutter, this is the cookie being summoned forth 

// How to write the class
// How create object instances
// - use the constructor(){} method. contained in this type of function is something like setup(){} in P5js

// class bubble {
// 	constructor() {
// 		this.x = 200;
// 		this.y = 100;
// 	}
// 	move() {
// 		this.x += random(-5,5);
// 		this.y += random(-5,5);
// 		// this is what it means for a  bubble to move
// 	}
// 	show() {
// 		stroke(255);
// 		strokeWeight(4);
// 		noFill();
// 		ellipse(this.x,this.y,24,24);
// 	}
// }

// what is this.etc? In this example, it is a reference to the current object template, the default values
// This is often referred to as encapsulation.

// How to implement variables into the objects 
// How to implement objects into functions, practical examples

//// Passing in parameters to a class, summoning the class multiple times, 
//// Creates to bubbles with random starting locations and 1 of them has a different color 
//// for each run. 

// let bubble;
// let ranRGB = random(255);
// // let g = random(-10,10);


// function setup() {
//   createCanvas(400, 400);
//   let ranRGB = random(255);

//   bubble1 = new Bubble(200,200,100,random(100));
//   bubble2 = new Bubble(100,135,random(100),ranRGB);
// }

// function draw() {
//   background(0);
//   bubble1.move();
//   bubble1.show();
//   bubble2.move();
//   bubble2.show();
  
// }

// class Bubble {
// 	constructor(x,y,r,f) {
// 		this.x = x;
// 		this.y = y;
//         this.r = r;
//         this.f = f;
// 	}
// 	move() {
// 		this.x += random(-5,5);
// 		this.y += random(-5,5);
// 		// this is what it means for a  bubble to move
// 	}
// 	show() {
// 		stroke(255);
// 		strokeWeight(4);
// 		fill(this.f);
// 		ellipse(this.x,this.y,this.r*2);
// 	}

// 	edges() {
// 		if (this.x>width){this.x*-1} else if (this.x<width) {this.x*-1}
// 	}
// }
////------------------------------------------------------------
//// This is a function that makes the object bubbles bounce within the screen container

// let bubble;

// function setup() {
//   createCanvas(400, 400);
//   bubble1 = new Bubble(200,200,100,random(100),3,1);
//   bubble2 = new Bubble(100,135,random(100),random(255),1,3);
// }

// function draw() {
//   background(220);
//     background(0);
//   bubble1.move();
//   bubble1.show();
//   bubble1.bounce();
//   bubble2.move();
//   bubble2.show();
//   bubble2.bounce();
// }

// class Bubble {
// 	constructor(x,y,r,f,xSpeed,ySpeed) {
// 		this.x = x;
// 		this.y = y;
//         this.r = r;
//         this.f = f;
//         this.xSpeed = xSpeed;
//         this.ySpeed = ySpeed;
// 	}

// 	move() {
// 		this.x += this.xSpeed;
// 		this.y += this.ySpeed;
// 		// this is what it means for a  bubble to move
// 	}
// 	show() {
// 		stroke(255);
// 		strokeWeight(4);
// 		fill(this.f);
// 		ellipse(this.x,this.y,this.r*2);
// 	}
//     	bounce() {
//         ellipseMode(CENTER)
// 		if (this.x>width || this.x<0){this.xSpeed = this.xSpeed *-1}
//         if (this.y>height || this.y<0){this.ySpeed = this.ySpeed *-1}
// 	}

// }
////------------------------------------------------------------
//// This is how you link a js file into html, which we know ostensibly
// <script src="theScriptUWant"></script>
// This is good for scaling large programs by separating the classes from the rest of your code.

////------------------------------------------------------------
// // So this is a small example of arrays in use, 
// // More importantly the idea of a controllable variable that gets passed into functions
// // Controlling elements dynamically through user input. A good example of practical use 
// // of variables in functions, loops, arrays.

// let bubble;
// let nums = [44,66,88,-22,100]
// let words = ["howdy", "yall", "slowDown", "trailHand"]
// let index = 0;

// function mousePressed(){
//   index = index + 1;
//   if (index==words.length){
//     index = 1;
//   }
// }

////------------------------------------------------------------

// This is a screensaver I made on my own
// It loops through an array of words and makes them bounce within the bounds of the window


// let word;
// let words = ["Select", "Corporation", "Horizon", "Market", "General", "Hospital", "Forza", "MotorSport"]
// let index = 1;

// function setup() {
//   createCanvas(400, 400);
//   word1 = new Word(100,100,46,random(-4,4),1);
//   word2 = new Word(200,200,24,1,2);
// }

// function draw() {
//   background(0);
//   word1.move();
//   word1.show();
//   word1.bounce();
//   word2.move();
//   word2.show();
//   word2.bounce();
  
  
// }

// class Word {
//   constructor(x,y,s,xSpeed,ySpeed){
//     this.x = x;
//     this.y = y;
//     this.s = s;
//     this.xSpeed = xSpeed;
//     this.ySpeed = ySpeed;
//   }
  
//   move () {
//     this.x += this.xSpeed;
//     this.y += this.ySpeed;
//   }
//   show() {
//     // stroke(100,100,53);
//     fill(255,100,random(255));
//     textSize(this.s);
//     // text("Hello",this.x,this.y);
//     text(words[index],this.x,this.y);
//     text(words[index+1], this.x,this.y+64);
//   }
//   bounce() {
//     if (this.x>width || this.x<0){this.xSpeed = this.xSpeed *-1}
//     if (this.y>height || this.y<0){this.ySpeed = this.ySpeed *-1}
// 	}
// }

// function mousePressed(){
//   index += 1;
//   if (index == words.length){
//     index = 0
//   }
// }

////------------------------------------------------------------

//// Lets try and generate some sort of DFL Object today. 


// class DFL {
//   constructor(width,height,numLines,numSect,med){
//     this.width = width;
//     this.height = height;
//     this.numLines = numLines;
//     this.numSect = numSect;
//     this.med = med;
//   }
//   placeText(){
    
//   }
//   textMarkup(){
    
//   }
//   linesBox(){
    
//   }
//   show(){
    
//   }
// }















