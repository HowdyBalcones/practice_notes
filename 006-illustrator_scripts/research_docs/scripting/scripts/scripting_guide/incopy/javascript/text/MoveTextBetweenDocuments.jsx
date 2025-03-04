//MoveTextBetweenDocuments.jsx
//An InCopy JavaScript
//
//Moves formatted text from one document to another.
main();
function main(){
	mySetup();
	mySnippet();
	myTeardown();
}
function mySetup(){
}
function mySnippet(){
	//<fragment>
	var mySourceDocument = app.documents.add();
	//Add text to the default story.
	var mySourceStory = mySourceDocument.stories.item(0);
	mySourceStory.contents = "This is the source text.\rThis text is not the source text.";
	mySourceStory.paragraphs.item(0).pointSize = 24;
	//Create a new document to move the text to.
	var myTargetDocument = app.documents.add();
	//Create a text frame in the target document.
	var myTargetStory = myTargetDocument.stories.item(0);
	myTargetStory.contents = "This is the target text. Insert the source text after this paragraph.\r";
	mySourceStory.paragraphs.item(0).duplicate(LocationOptions.after, myTargetStory.insertionPoints.item(-1));
	//</fragment>
}
function myTeardown(){
}
