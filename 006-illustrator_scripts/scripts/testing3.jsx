
var doc = app.activeDocument;

var numLayers = 5;

function addLayers(numLayers) {
	for (var i = 0; i < numLayers; i++) {
		var newLayer = doc.layers.add();
		newLayer.name = "Added_Layer_" + (i + 1);
	}
}

addLayers(numLayers);
