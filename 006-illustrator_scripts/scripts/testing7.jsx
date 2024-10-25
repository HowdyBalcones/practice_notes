var doc = app.activeDocument;
var linesLayer = doc.layers.getByName("Lines");
var lines = linesLayer.pathItems;

function replaceLineWithText() {
	



	for (var i = 0; i < lines.length; i++) {
		var line = lines[i];
		var startX = line.pathPoints[0].anchor[0];
		var startY = line.pathPoints[0].anchor[1];
		var endX = line.pathPoints[1].anchor[0];
		var endY = line.pathPoints[1].anchor[1];

		var angle = Math.atan2(endY - startY, endX - startX) * (180 / Math.PI);
		
		var textFrame = doc.textFrames.add();
		textFrame.contents = "Your Text Here";
		textFrame.top = (startY + endY) / 2;
		textFrame.left = (startX + endX) / 2;

		textFrame.rotate(angle);
		line.remove();
	}

}

replaceLineWithText();
