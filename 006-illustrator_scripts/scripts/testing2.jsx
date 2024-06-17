
var doc = app.activeDocument;

var textFrame = doc.textFrames.add();
var layer = doc.activeLayer;
var newLayer = doc.layers.add();
var numLayers = 5;

function makeText() {
textFrame.contents = "Hello, World!"
textFrame.textRange.characterAttributes.size = 20;
textFrame.top = 200; // y-coordinate
textFrame.left = 100; // x-coordinate
}

function addLayers(numLayers) {
	for (var i = 0; i < numLayers; i++) {
	newLayer.name = "Added_Layer_" + (i + 1);
	}

}

function layerName() {
	layer.name = "Renamed_Layer"
}

makeText();
layerName();
addLayers(numLayers);
