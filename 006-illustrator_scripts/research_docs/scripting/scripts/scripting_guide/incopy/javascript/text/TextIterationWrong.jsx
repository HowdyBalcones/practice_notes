//TextIterationWrong.jsx
//An InCopy JavaScript
//
//Shows how *not* to iterate through text.
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
	var myDocument = app.documents.add();
	var myString = "Paragraph 1.\rDelete this paragraph.\rParagraph 2.\rParagraph 3.\rParagraph 4.\rParagraph 5.\rDelete this paragraph.\rParagraph 6.\r";
	var myStory = myDocument.stories.item(0);
	myStory.contents = myString;
	//The following for loop will fail to format all of the paragraphs.
	for(var myParagraphCounter = 0; myParagraphCounter < myStory.paragraphs.length; myParagraphCounter ++){
		if(myStory.paragraphs.item(myParagraphCounter).words.item(0).contents == "Delete"){
			myStory.paragraphs.item(myParagraphCounter).remove();
		}
		else{
			myStory.paragraphs.item(myParagraphCounter).pointSize = 24;
		}
	}
	//</fragment>
}
function myTeardown(){
}
