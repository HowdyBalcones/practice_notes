//FindText.jsx
//An InCopy JavaScript
//
//Shows how to find text.
main();
function main(){
	mySetup();
	mySnippet();
	myTeardown();
}
function mySetup(){
	//Create an example document.
	var myDocument = app.documents.add();
	var myStory = myDocument.stories.item(0);
	//Fill the text frame with placeholder text.
	var myString = "This is some text. This is some more text. This is even more example text.\rThis is text in another paragraph.";
	myStory.contents = myString;
}
function mySnippet(){
	//<fragment>
	//Clear the find/change preferences.
	app.findTextPreferences = NothingEnum.nothing;
	app.changeTextPreferences = NothingEnum.nothing;
	//Search the document for the string "Text".
	app.findTextPreferences.findWhat = "text";
	//Set the find options.
	app.findChangeTextOptions.caseSensitive = false;
	app.findChangeTextOptions.includeFootnotes = false;
	app.findChangeTextOptions.includeHiddenLayers = false;
	app.findChangeTextOptions.includeLockedLayersForFind = false;
	app.findChangeTextOptions.includeLockedStoriesForFind = false;
	app.findChangeTextOptions.includeMasterPages = false;
	app.findChangeTextOptions.wholeWord = false;
	var myFoundItems = app.documents.item(0).findText();
	alert("Found " + myFoundItems.length + " instances of the search string.");
	//</fragment>
}
function myTeardown(){
}