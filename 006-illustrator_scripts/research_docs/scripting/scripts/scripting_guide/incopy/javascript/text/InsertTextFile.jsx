//InsertTextFile.jsx
//An InCopy JavaScript
//
//Places a text file in text inside a text frame (without replacing the text).
main();
function main(){
	mySetup();
	mySnippet();
	myTeardown();
}
function mySetup(){
	var myDocument = app.documents.add();
	var myStory = myDocument.stories.item(0)
	myStory.contents = "Inserted text file follows:\r";
}
function mySnippet(){
	//<fragment>
	//Place a text file at the end of the text.
	//Parameters for InsertionPoint.place():
	//File as File object, 
	//[ShowingOptions as Boolean = False]
	//You'll have to fill in your own file path.
	var myDocument = app.documents.item(0);
	myDocument.stories.item(0).insertionPoints.item(-1).place(File("/c/test.txt"));
	//</fragment>
}
function myTeardown(){
}