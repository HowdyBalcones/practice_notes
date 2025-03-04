//ImprovedHelloWorld.jsx
//An InCopy JavaScript
//
///Get a reference to a font.
try{
	//Enter the name of a font on your system, if necessary.
	var myFont = app.fonts.item("Arial");
}
catch(myError){}
//Get the active document and assign the result to the variable "myDocument"
var myDocument = app.documents.item(0);
with(myDocument.stories.item(0)){
	//Change the font, size, and paragraph alignment.
	try{
		appliedFont = myFont;
	}
	catch(myError){}
	justification = Justification.centerAlign;
	pointSize = 48;
	//Enter the note at the last insertion point of the story.
	var myNote = insertionPoints.item(-1).notes.add();
	myNote.texts.item(0).contents = "This is a note."
}