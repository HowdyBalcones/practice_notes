//FindChangeText.jsx
//An InCopy JavaScript
//
//Shows how to find and change text.
main();
function main(){
	mySetup();
	mySnippet();
	myTeardown();
}
function mySetup(){
	var myDocument = app.documents.add();
	//Create a text frame on page 1.
	var myStory = myDocument.stories.item(0);
	var myString = "This is some copy. This is some more copy. This is even more example copy.\rThis is copy in another paragraph.";
	myStory.contents = myString;
}
function mySnippet(){
	//<fragment>
	//Clear the find/change preferences.
	app.findTextPreferences = NothingEnum.nothing;
	app.changeTextPreferences = NothingEnum.nothing;
	//Set the find options.
	app.findChangeTextOptions.caseSensitive = false;
	app.findChangeTextOptions.includeFootnotes = false;
	app.findChangeTextOptions.includeHiddenLayers = false;
	app.findChangeTextOptions.includeLockedLayersForFind = false;
	app.findChangeTextOptions.includeLockedStoriesForFind = false;
	app.findChangeTextOptions.includeMasterPages = false;
	app.findChangeTextOptions.wholeWord = false;
	//Search the document for the string "copy" and change it to "text".
	app.findTextPreferences.findWhat = "copy";
	app.changeTextPreferences.changeTo = "text";
	app.documents.item(0).changeText();
	//Clear the find/change preferences after the search.
	app.findTextPreferences = NothingEnum.nothing;
	app.changeTextPreferences = NothingEnum.nothing;
	//</fragment>
}
function myTeardown(){
}