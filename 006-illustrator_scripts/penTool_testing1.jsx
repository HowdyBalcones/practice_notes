var doc = app.activeDocument;
var artboard = doc.artboards[0];
var pathItem = doc.pathItems[0];

function makeLine(xPthe oint, yPoint) {

	var line = doc.pathItems.add();
	line.setEntirePath([[0,0], [0,-100], [100,-100]]);
}




function centerItem(selectedItem, artboard) {
	var abBounds = artboard.artboardRect;
	var left = abBounds[0];
	var top = abBounds[1];
	var right = abBounds[2];
	var bottom = abBounds[3];

	//find the width and height of the artboard
	var abWidth = abBounds[2] - abBounds[0];
	var abHeight = abBounds[1] - abBounds[3];

	//find the center of the artboard
	var abCenterX = abBounds[0] + abWidth / 2;
	var abCenterY = abBounds[1] - abHeight / 2;

	//Get the dimensions of the path object
	var itemBounds = pathItem.geometricBounds;
	var itemWidth = itemBounds[2] - itemBounds[0];
	var itemHeight = itemBounds[1] - itemBounds[3];

	//Calculate the new position for the pathItem to center it on the artboard
	var newX = abCenterX - itemWidth / 2;
	var newY = abCenterY - itemHeight / 2;

	//set the new position of the path item
	pathItem.position = [newX, newY];

}

makeLine();
