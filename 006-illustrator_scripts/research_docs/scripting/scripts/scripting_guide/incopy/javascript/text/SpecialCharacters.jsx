//SpecialCharacters.jsx
//An InCopy JavaScript
//
//Shows how to enter special characters in text.
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
	//Entering special characters directly.
	myStory.contents = "Registered trademark: ®\rCopyright: ©\rTrademark: ™\r";
	//Entering special characters by their Unicode glyph ID value:
	myStory.insertionPoints.item(-1).contents = "Not equal to: \u2260\rSquare root: \u221A\rParagraph: \u00B6\r";
	//Entering InDesign special characters by their enumerations:
	myStory.insertionPoints.item(-1).contents = "Automatic page number marker:";
	myStory.insertionPoints.item(-1).contents = SpecialCharacters.autoPageNumber;
	myStory.insertionPoints.item(-1).contents = "\r";
	myStory.insertionPoints.item(-1).contents = "Section symbol:";
	myStory.insertionPoints.item(-1).contents = SpecialCharacters.sectionSymbol;
	myStory.insertionPoints.item(-1).contents = "\r";
	myStory.insertionPoints.item(-1).contents = "En dash:";
	myStory.insertionPoints.item(-1).contents = SpecialCharacters.enDash;
	myStory.insertionPoints.item(-1).contents = "\r";
	//</fragment>
}
function myTeardown(){
}
