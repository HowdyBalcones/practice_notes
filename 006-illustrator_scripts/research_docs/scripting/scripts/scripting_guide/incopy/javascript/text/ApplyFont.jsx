//ApplyFont.jsx
//An InCopy JavaScript
//
//Shows how to get a list of fonts and display them in a dialog box,
//and how to apply a font to a range of text.
//
main();
function main(){
	mySetup();
	mySnippet();
	myTeardown();
}
function mySetup(){
	//Creates a text frame in an example document
	//and sizes the text frame to match the page margins.
	var myDocument = app.documents.add();
	var myStory = myDocument.stories.item(0);
	//Fill the story with placeholder text.
	var myTextFrame = myStory.textContainers[0];
	myTextFrame.contents = TextFrameContents.placeholderText;
}
function mySnippet(){
	var myDocument = app.documents.item(0);
	var myStory = myDocument.stories.item(0);
	var myStartCharacter = myStory.paragraphs.item(2).words.item(3).characters.item(0);
	var myEndCharacter  = myStory.paragraphs.item(4).words.item(-1).characters.item(-1);
	var myText = myStory.texts.itemByRange(myStartCharacter, myEndCharacter);
	myDisplayDialog(myText);
}
function myTeardown(){
}
function myDisplayDialog(myText){
	var myFontNamesList = app.fonts.everyItem().name;
	var myDialog = app.dialogs.add({name:"Fonts"});
	with(myDialog){
		with(dialogColumns.add()){
			with(dialogColumns.add()){
				staticTexts.add({staticLabel:"Font Name:"});
			}
			with(dialogColumns.add()){
				var myFontDropdown = dropdowns.add({stringList: myFontNamesList, selectedIndex:0});
			}
		}
	}
	var myResult = myDialog.show();
	if(myResult == true){
		var myFontName = myFontNamesList[myFontDropdown.selectedIndex];
		myDialog.destroy();
		myApplyFont(myText, myFontName);
	}
	else{
		myDialog.destroy();
	}
}
function myApplyFont(myText, myFontName){
	//<fragment>
	//Given a text object "myTextObject" and a font "myFontName"...
	try{
		myText.appliedFont = app.fonts.item(myFontName);
	}
	catch(myError){
		alert("Font " + myFontName + " could not be applied.");
	}
	//</fragment>
}