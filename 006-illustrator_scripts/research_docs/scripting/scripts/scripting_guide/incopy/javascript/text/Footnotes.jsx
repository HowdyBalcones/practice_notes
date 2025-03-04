//Footnotes.jsx
//An InCopy JavaScript
//
//Shows how to add footnotes.
main();
function main(){
	mySetup();
	mySnippet();
	myTeardown();
}
function mySetup(){
	//Create an example document.
	var myDocument = app.documents.add();
	with(myDocument.footnoteOptions){
		separatorText = "\t";
		markerPositioning = FootnoteMarkerPositioning.superscriptMarker;
	}
	//Create a text frame on page 1.
	var myStory = myDocument.stories.item(0);
	var myTextFrame = myStory.textContainers[0];
	myTextFrame.contents = TextFrameContents.placeholderText;
}
function mySnippet(){
	//<fragment>
	var myWord, myFootnote;
	var myDocument = app.documents.item(0);
	var myStory = myDocument.stories.item(0);
	//Add four footnotes at random locations in the story.
	for(myCounter = 0; myCounter < 4; myCounter ++){
		myWord = myStory.words.item(myGetRandom(0, myStory.words.length));
		var myFootnote = myWord.insertionPoints.item(-1).footnotes.add();
		//Note: when you create a footnote, it contains text--the footnote marker
		//and the separator text (if any). If you try to set the text of the footnote
		//by setting the footnote contents, you will delete the marker. Instead, append
		//the footnote text, as shown below.
		myFootnote.insertionPoints.item(-1).contents = "This is a footnote.";
	}
	//</fragment>
}
function myTeardown(){
}
//This function gets a random number in the range myStart to myEnd.
function myGetRandom(myStart, myEnd){
	var myRange = myEnd - myStart; 
	return myStart + Math.floor(Math.random()*myRange); 
}