//CreateStyles.jsx
//An InCopy CS3 JavaScript
//
//Shows how to create and apply a paragraph style and a character style.
main();
function main(){
	mySetup();
	mySnippet();
	myTeardown();
}
function mySetup(){
	var myDocument = app.documents.add();
	//Create a color for use by one of the paragraph styles we'll create.
	try{
		myColor = myDocument.colors.item("Red");
		//If the color does not exist, trying to get its name will generate an error.
		myName = myColor.name;
	}
	catch (myError){
		//The color style did not exist, so create it.
		myColor = myDocument.colors.add({name:"Red", model:ColorModel.process, colorValue:[0, 100, 100, 0]});
	}
	var myStory = myDocument.stories.item(0);
	myStory.contents = "Normal text. Text with a character style applied to it. More normal text.";
}
function mySnippet(){
	var myParagraphStyle, myCharacterStyle, myColor, myName;
	//<fragment>
	var myDocument = app.documents.item(0);
	var myStory = myDocument.stories.item(0);
	//Create a character style named "myCharacterStyle" if 
	//no style by that name already exists.
	try{
		myCharacterStyle = myDocument.characterStyles.item("myCharacterStyle");
		//If the style does not exist, trying to get its name will generate an error.
		myName = myCharacterStyle.name;
	}
	catch (myError){
		//The style did not exist, so create it.
		myCharacterStyle = myDocument.characterStyles.add({name:"myCharacterStyle"});
	}
	//At this point, the variable myCharacterStyle contains a reference to a character 
	//style object, which you can now use to specify formatting.
	myColor = myDocument.colors.item("Red");
	myCharacterStyle.fillColor = myColor;
	//Create a paragraph style named "myParagraphStyle" if 
	//no style by that name already exists.
	try{
		myParagraphStyle = myDocument.paragraphStyles.item("myParagraphStyle");
		//If the paragraph style does not exist, trying to get its name will generate an error.
		myName = myParagraphStyle.name;
	}
	catch (myError){
		//The paragraph style did not exist, so create it.
		myParagraphStyle = myDocument.paragraphStyles.add({name:"myParagraphStyle"});
	}
	//At this point, the variable myParagraphStyle contains a reference to a paragraph 
	//style object, which you can now use to specify formatting.
	myStory.texts.item(0).applyParagraphStyle(myParagraphStyle, true);
	var myStartCharacter = myStory.characters.item(13);
	var myEndCharacter = myStory.characters.item(54);
	myStory.texts.itemByRange(myStartCharacter, myEndCharacter).applyCharacterStyle(myCharacterStyle);
	//</fragment>
}
function myTeardown(){
}