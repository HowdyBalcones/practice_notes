
var doc = app.activeDocument;
var layerNames = ["Background", "Artwork", "Indicia", "DFL", "Dieline", "Specs"]

function addLayers(layerNames) {
	for (var i = 0; i < layerNames.length; i++) {
		var newLayer = doc.layers.add();
		newLayer.name = layerNames[i]; 
	}
}

addLayers(layerNames);
