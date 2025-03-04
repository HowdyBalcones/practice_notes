//ReplaceText.jsx
//An InCopy JavaScript
//
//Enters text in the default story, and then replaces
//the text in the second paragraph.
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
	var myStory = myDocument.stories.item(0);
	myStory.contents = "Paragraph 1.\rParagraph 2.\rParagraph 3.\r";
	//Replace the text in the second paragraph without replacing
	//the return character at the end of the paragraph. To do this,
	//we'll use the ItemByRange method.
	var myStartCharacter = myStory.paragraphs.item(1).characters.item(0);
	var myEndCharacter = myStory.paragraphs.item(1).characters.item(-2);
	myStory.texts.itemByRange(myStartCharacter, myEndCharacter).contents = "This text replaces the text in paragraph 2.";
	//</fragment>
}
function myTeardown(){
}
