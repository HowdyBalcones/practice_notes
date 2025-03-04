//CopyUnformattedText.jsx
//An InCopy JavaScript
//
//Shows how to remove formatting from text as you move it to other locations in a document.
main();
function main(){
	mySetup();
	mySnippet();
	myTeardown();
}
function mySetup(){
	var myDocument = app.documents.add();
	var myStory = myDocument.stories.item(0);
	myStory.contents = "This is a formatted string.\rText pasted after this text will retain its formatting.\r\rText moved to the following line will take on the formatting of the insertion point.\rItalic: ";
	//Apply formatting to the first paragraph.
	myStory.paragraphs.item(0).fontStyle = "Bold";
	//Apply formatting to the last paragraph.
	myStory.paragraphs.item(-1).fontStyle = "Italic";
}
function mySnippet(){
	//<fragment>
	//Copy from one location to another using a simple copy.
	var myStory = app.documents.item(0).stories.item(0);
	app.select(myStory.paragraphs.item(0).words.item(0));
	app.copy();
	app.select(myStory.paragraphs.item(1).insertionPoints.item(-1));
	app.paste();
	//Copy the unformatted string from the first word to the end of the story
	//by getting and setting the contents of text objects. Note that this doesn't 
	//really copy the text; it replicates the text string from one text location
	//to another.
	myStory.insertionPoints.item(-1).contents = myStory.paragraphs.item(0).words.item(0).contents;
	//</fragment>
}
function myTeardown(){
}