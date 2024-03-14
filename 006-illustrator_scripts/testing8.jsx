var doc = app.activeDocument;
var line = doc.pathItems[0];

function replaceLineWithText(line) {
	
	// calculate angle of rotation
	var angle = Math.atan2(line.pathPoints[1].anchor[1] - line.pathPoints[0].anchor[1],
	line.pathPoints[1].anchor[0] - line.pathPoints[0].anchor[0]) * (180 / Math.PI);

	// Create a new text frame
	var textFrame = doc.textFrames.add();
	textFrame.contents = "Free Palestine!";
	textFrame.top = line.pathPoints[0].anchor[1];
	textFrame.left = line.pathPoints[0].anchor[0];

	// Rotate the text frame to match the lines orientation
	textFrame.rotate(angle);

	// Calculate the length of the line
	var dx = line.pathPoints[1].anchor[0] - line.pathPoints[0].anchor[0];
	var dy = line.pathPoints[1].anchor[1] - line.pathPoints[0].anchor[1];
	var lineLength = Math.sqrt(dx*dx + dy*dy);

	// Scale the text frame to match the line's length
	// Assuming the text frame has a default width of 100 points for simplicity
	var scaleFactor = lineLength / 100;
	textFrame.resize(scaleFactor * 100, scaleFactor * 100); //uniform scaling

	line.remove();
}


for (var i = doc.pathItems.length - 1; i >= 0; i--) {
	var line = doc.pathItems[i];

	if (line.pathPoints.length == 2) {
		replaceLineWithText(line);
	}
}


