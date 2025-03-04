//ReplaceWord.jsx
//An InCopy CS3 JavaScript
//
//Enters text in the default story and then replaces
//a word in the story with a different phrase.
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
	myStory.contents = "This is some example text.";
	//Replace the third word "some" with the phrase
	//"a little bit of".
	myStory.words.item(2).contents = "a little bit of";
	//</fragment>
}
function myTeardown(){
}
