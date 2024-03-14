var doc = app.activeDocument;

var targetLayer = doc.layers.getByName("ThisLayer1");
var layerNames = [];
var pathName = doc.fullName.fsName;
var newLayerNames = [];


//alert("The pathname of the current document is " + pathName);


//
//for (var i = 0; i < targetLayer.pageItems.length; i++) {
//	var pageItem = targetLayer.pageItems[i];
//
//	if (pageItem.name) {
//		alert("Object Name: " + pageItem.name);
//	} else {
//		alert("Unnamed Object");
//	}
//}

for (var i = 0; i < doc.layers.length; i++) {
	layerNames.push(doc.layers[i].name);
}


for (var i = 0; i < doc.layers.length; i++) {
	var originalLayer = doc.layers[i];
	var newLayer = doc.layers.add();
	newLayer.name = "Copy_of_" + originalLayer.name;
	newLayerNames.push(newLayer.name);
}


alert("Current Layers: \n" + layerNames.join("\n"));
