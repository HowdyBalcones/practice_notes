//AddText.jsx
//An InCopy JavaScript
//
//Shows how to add text to an InCopy document.
main();
function main(){
	mySetup();
	mySnippet();
	myTeardown();
}
function mySetup(){
}
function mySnippet(){
	var myDocument = app.documents.add();
	//Add text to the default story.
	var myStory = myDocument.stories.item(0);
	myStory.contents = "This is the first paragraph of example text.";
	//To add more text to the story, we'll use the last insertion point 
	//in the story. ("\r" is a return character in JavaScript.)
	var myInsertionPoint = myStory.insertionPoints.item(-1);
	myInsertionPoint.contents = "\rThis is the second paragraph.";
}
function myTeardown(){
}
