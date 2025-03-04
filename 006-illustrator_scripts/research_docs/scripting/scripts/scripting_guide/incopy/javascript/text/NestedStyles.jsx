//NestedStyles.jsx
//An InCopy JavaScript
//
//Shows how to create a paragraph style containing a nested style.
main();
function main(){
	mySetup();
	mySnippet();
	myTeardown();
}
function mySetup(){
	var myParagraphStyle, myCharacterStyle, myColor, myName;
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
	myStory.textContainers[0].contents = TextFrameContents.placeholderText;
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
}
function mySnippet(){
	//<fragment>
	var myStory = app.documents.item(0).stories.item(0);
	var myParagraphStyle = app.documents.item(0).paragraphStyles.item("myParagraphStyle");
	var myCharacterStyle = app.documents.item(0).characterStyles.item("myCharacterStyle");
	var myNestedStyle = myParagraphStyle.nestedStyles.add({appliedCharacterStyle:myCharacterStyle, delimiter:".", inclusive:true, repetition:1});
	var myStartCharacter = myStory.characters.item(0);
	var myEndCharacter = myStory.characters.item(-1);
	//Use the itemByRange method to apply the paragraph to all of the text in the story.
	//(Note that the story object does not have the applyStyle method.)
	myStory.texts.itemByRange(myStartCharacter, myEndCharacter).applyParagraphStyle(myParagraphStyle, true);	
	//</fragment>
}
function myTeardown(){
}