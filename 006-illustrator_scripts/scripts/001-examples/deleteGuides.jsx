var doc = app.activeDocument;

for (var i = doc.layers.length - 1; i >= 0; i--) {
	var layer = doc.layers[i];
	if (layer.guides) {
		layer.remove();
	}
}
