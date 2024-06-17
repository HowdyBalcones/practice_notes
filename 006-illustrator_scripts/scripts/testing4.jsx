
var doc = app.activeDocument;
var selectedItems = doc.selection;
var artboard = doc.artboards[0];

function getRandomInt(min, max) {
	min = Math.ceil(min);
	max = Math.floor(max);
	return Math.floor(Math.random() * (max - min + 1)) + min;
}

function setFillColor(selectedItem) {

	if (selectedItem.typename == "GroupItem") {
		for (var j = 0; j < selectedItem.pageItems.length; j++) {
			var innerItem = selectedItem.pageItems[j];
			setFillColor(innerItem);
		}
	
	} else if (selectedItem.typename == "CompoundPathItem") {
		for (var j = 0; j < selectedItem.pathItems.length; j++) {
			var innerItem = selectedItem.pathItems[j];
			setFillColor(innerItem);
		}
	} else if (selectedItem.fillColor) {

	var rgbColor = new RGBColor();
	rgbColor.red = getRandomInt(0, 255);
	rgbColor.green = getRandomInt(0, 255);
	rgbColor.blue = getRandomInt(0, 255);
	selectedItem.fillColor = rgbColor;
	
	}
}

function rotateItem(selectedItem) {
	var angle = getRandomInt(0, 360); // random angle
	selectedItem.rotate(angle);
}

function scaleItem(selectedItem) {
	var scaleFactor = getRandomInt(50, 200); // random between 50% and 200%
	selectedItem.resize(scaleFactor, scaleFactor); // uniform scaling
}

function repositionItem(selectedItem, artboard) {
	var abBounds = artboard.artboardRect;
	var left = abBounds[0];
	var top = abBounds[1];
	var right = abBounds[2];
	var bottom = abBounds[3];

	var newPositionX = getRandomInt(left, right - selectedItem.width);
	var newPositionY = getRandomInt(bottom + selectedItem.height, top);
	selectedItem.position = [newPositionX, newPositionY];
}

// check if anything is selected
if (selectedItems.length > 0) {

	for (var i = 0; i < selectedItems.length; i++) {
		var selectedItem = selectedItems[i];
		setFillColor(selectedItem);
		rotateItem(selectedItem);
		scaleItem(selectedItem);
		repositionItem(selectedItem, artboard);
	}

} else {
	alert("No items are selected!");
}

