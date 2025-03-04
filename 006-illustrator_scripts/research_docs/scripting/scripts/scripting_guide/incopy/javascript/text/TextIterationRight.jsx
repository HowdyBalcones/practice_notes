//TextIterationRight.jsx
//An InCopy JavaScript
//
//Shows the correct way to iterate through text.
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
	//The following for loop will format all of the paragraphs by iterating 
	//backwards through the paragraphs in the story.
	for(var myParagraphCounter = myStory.paragraphs.length-1; myParagraphCounter >= 0; myParagraphCounter --){
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
