
var doc = app.activeDocument;

//alert("There are " + doc.textFrames.length + " text frames.");
//alert("There are " + doc.stories.length + " stories.");


// make a new textFrame, set the content, set the position, set fontsize, set font

function newTextFrame() {
	var textFrame = doc.textFrames.add();
	textFrame.contents = "Hello, World!"
	textFrame.position = [100, 100];
	textFrame.textRange.characterAttributes.size = 25;
	textFrame.textRange.characterAttributes.textFont = textFonts.getByName(Cambria);

}

newTextFrame();
