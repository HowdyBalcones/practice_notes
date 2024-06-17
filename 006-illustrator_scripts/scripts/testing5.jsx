
var doc = app.activeDocument;
var selectedItems = doc.selection;

function getRandomInt(min, max) {
        min = Math.ceil(min);
        max = Math.floor(max);
        return Math.floor(Math.random() * (max - min + 1)) + min;
}

var axiom = "F+F+F+F";
var rules = {
	
	"F" : "F+f-FF+F+FF+Ff+FF-f+FF-F-FF-Ff-FFF",
	//"F" : "F+FF-FF-F-F+F+F+F-F-F+F+FF+FF-F"
	"f" : "ffffff"
	//"F" : "F-F+F+F+FF-F-F+F"
	//"F" : "F+F-F-F+F"
};

var generations = getRandomInt(2,2);
var angle = getRandomInt(90,90);
var length = getRandomInt(5,5);

function applyRules(input) {
	var output = "";
	for (var i = 0; i < input.length; i++) {
		var letter = input.charAt(i);
		output += (rules[letter] || letter);
	}
	return output;
}

function generateLSystem(axiom, generations) {
	var result = axiom;
	for (var i = 0; i < generations; i++) {
		result = applyRules(result);
	}
	return result;
}

function drawLSystem(lsystemString, length, angle) { 
	var currentX = doc.width / 2;
	var currentY = doc.height / 2;
	var stack = [];
	var direction = 0;

	for (var i = 0; i < lsystemString.length; i++) {
		var letter = lsystemString.charAt(i);

		switch (letter) {
			case "F":
				var newX = currentX + length * Math.cos(direction * Math.PI / 180);
				var newY = currentY - length * Math.sin(direction * Math.PI / 180);
				var path = doc.pathItems.add();
				path.setEntirePath([[currentX, currentY], [newX, newY]]);
				currentX = newX;
				currentY = newY;
				break;
			case "f":
				currentX += length * Math.cos(direction * Math.PI / 180);
				currentY -= length * Math.cos(direction * Math.PI / 180);
				break;
			case "+":
				direction += angle;
				break;
			case "-":
				direction -= angle;
				break;
			case "[":
				stack.push([currentX, currentY, direction]);
				break;
			case "]":
				var state = stack.pop();
				currentX = state[0];
				currentY = state[1];
				direction = state[2];
				break;
		}
	}
}

var lsystemString = generateLSystem(axiom, generations);
drawLSystem(lsystemString, length, angle);
