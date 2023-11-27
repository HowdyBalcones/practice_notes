// This is the code to toggle the menu on a click. 
// It targets the second level in our "dropdown" container, where the "dropdownMenu" is, the content of the menu is the third level
// also referred to as a toggle pattern, changes between mutable states


function toggleDropdown() {
	var dropdown = document.getElementById("dropdownMenu");
	if (dropdown.style.display === "none") {
		dropdown.style.display = "block";
	} else {
		dropdown.style.display = "none";
	}
}

// Playing with DOM manipulation
// Here we make variables that attach to an unordered list, the list elements, and store some text to be added
// Then we append the text to the list element, then append the list element to the ul element

var ul = document.getElementById("myList");
var li = document.createElement("li");
var text = document.createTextNode("ListItem5");
var text2 = document.createTextNode("ListItem6");
var text3 = document.createTextNode("ListItem7");

li.appendChild(text);
li.appendChild(text2);
li.appendChild(text3);
ul.appendChild(li);

// Updating text in a paragraph element
// Being accurate and practical with naming will be essential, make sure everrything is typed correctly

var paragraph = document.getElementById("testParagraph");
var newText = document.createTextNode("This is updated testText in our TestParagraph.");
	while (paragraph.firstChild) {
		paragraph.removeChild(paragraph.firstChild);
	}

paragraph.appendChild(newText);


// Dynamic Content -- would normally take input from user or output from some other function

var result = 1234 + 5678;
var displayArea = document.getElementById("resultDisplay");
var resultText = document.createTextNode("The result is: " + result);

while (displayArea.firstChild) {
	displayArea.removeChild(displayArea.firstChild);
}

displayArea.appendChild(resultText);

// Using the textContent method to replace, add text

var divContent = document.getElementById("info").textContent;
console.log(divContent);

document.getElementById("info").textContent = "This is the updated Text Muahahaha!!";

// Removing the child elements from a node
