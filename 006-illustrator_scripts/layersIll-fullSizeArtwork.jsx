var doc = app.activeDocument;
var layerNames = ["Guides", "LCES", "LCIS", "CLUBHOUSE/FITNESS", "BUILDING-X", "SITE_SIGNAGE", "AMENITY"]

function addLayers(layerNames) {
	for (var i = 0; i < layerNames.length; i++) {
		var newLayer = doc.layers.add();
		newLayer.name = layerNames[i]; 
	}
}

addLayers(layerNames);
