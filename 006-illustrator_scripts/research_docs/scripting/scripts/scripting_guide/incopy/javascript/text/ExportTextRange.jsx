//ExportTextRange.jsx
//An InCopy JavaScript
//
//Creates a story in an example document and then exports 
//some of the text to a text file.
main();
function main(){
	mySetup();
	mySnippet();
	myTeardown();
}
function mySetup(){
	var myDocument = app.documents.add();
	var myStory = myDocument.stories.item(0);
	//Fill the story with placeholder text.
	var myTextFrame = myStory.textContainers[0];
	myTextFrame.contents = TextFrameContents.placeholderText;
}
function mySnippet(){
	//<fragment>
	var myStory = app.documents.item(0).stories.item(0);
	var myStartCharacter = myStory.paragraphs.item(0).characters.item(0);
	var myEndCharacter = myStory.paragraphs.item(1).characters.item(-1);
	var myText = myStory.texts.itemByRange(myStartCharacter, myEndCharacter);
	//Text exportFile method parameters:
	//Format as ExportFormat
	//To As File
	//[ShowingOptions As Boolean = False]
	//
	//Format parameter can be:
	//ExportFormat.inCopyCSDocument
	//ExportFormat.inCopyDocument
	//ExportFormat.rtf
	//ExportFormat.taggedText
	//ExportFormat.textType
	//
	//Export the text range. You'll have to fill in a valid file path on your system.
	myText.exportFile(ExportFormat.textType, File("/c/test.txt"));
	//</fragment>
}
function myTeardown(){
}
