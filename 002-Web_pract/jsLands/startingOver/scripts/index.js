//const myHeading = document.querySelector("h1")
//myHeading.textContent = "Hello Globe!";

//test this in the console! it runs just fine, live. Pretty cool.


function multiply(num1, num2) {
	let result = num1 * num2;
	return result;
}

multiply(4, 7);
multiply(20, 20);
multiply(0.5, 999);


// the empty function here is called an anonymous function
// also known as an arrow function

// document.querySelector("html").addEventListener("click", function() {
// 	alert("Your Freeking Clicking!");
// });

// document.querySelector("html").addEventListener("click", () => {
//	alert("Your Freeking Clicking!");
// });


// this changes between two images on a click

const myImage = document.querySelector("img");

myImage.onclick = () => {
	const mySrc = myImage.getAttribute("src");
	if (mySrc === "images/01944_Tylenol_Extra_Strength-20ct.png") {
		myImage.setAttribute("src", "images/12947-Tylenol_Cold-Single.png");
	} else {
		myImage.setAttribute("src", "images/01944_Tylenol_Extra_Strength-20ct.png");
	}
};

// this does something with a button

 let myButton = document.querySelector("button");
 let myHeading = document.querySelector("h1");

 function setUserName() {
	const myName = prompt("Please Enter Your Name.");
	 
	if (!myName) {
		 setUserName();
	} else {

	localStorage.setItem("name", myName);
	myHeading.textContent = `You are setting up an account for ${myName}`;

	}
}

//if (!localStorage.getItem("name")) {
//	setUserName();
//} else {
//	const storedName = localStorage.getItem("name");
//	myHeading.textContent = `You are setting up an account for ${myName}`;
//};

myButton.onclick = () => {
	setUserName();
};
