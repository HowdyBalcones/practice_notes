var doc = app.activeDocument;

var circle = doc.pathItems.ellipse(50,300,100,100);
var rect = doc.pathItems.rectangle(100,100,100,100);

var textFrame = doc.textFrames[0];
textFrame.textRange.characterAttributes.textFont = textFonts.getByName("Seravek");

var selection = doc.selection;
for (var i = 0; i < selection.length; i++) {
	selection[i].duplicate();
}

