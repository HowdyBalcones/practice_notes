//ExportTextFile.jsx
//An InCopy JavaScript
//
//Creates a story in an example document and then exports the text to a text file.
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
	//Text exportFile method parameters:
	//Format as ExportFormat
	//To As File
	//[ShowingOptions As Boolean = False]
	//
	//Format parameter can be:
	//ExportFormat.rtf
	//ExportFormat.taggedText
	//ExportFormat.textType
	//
	//Export the story as text. You'll have to fill in a valid file path on your system.
	myStory.exportFile(ExportFormat.textType, File("/c/test.txt"));}
	//</fragment>
function myTeardown(){
}
