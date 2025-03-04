//FindChangeFormatting.jsx
//An InCopy JavaScript
//
//Shows how to find and change text formatting.
//
main();
function main(){
	mySetup();
	mySnippet();
	myTeardown();
}
function mySetup(){
	var myDocument = app.documents.add();
	var myStory = myDocument.stories.item(0);
	var myString = "This is some copy.\rThis is some more copy.\rThis is even more example copy.\rThis is copy in another paragraph.";
	myStory.contents = myString;
	//Apply formatting to the text.
	myStory.paragraphs.item(0).pointSize = 24;
	myStory.paragraphs.item(1).pointSize = 12;	
	myStory.paragraphs.item(2).pointSize = 24;	
	myStory.paragraphs.item(3).pointSize = 12;	
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
	//Search the document for the 24 point text and change it to 10 point text.
	app.findTextPreferences.pointSize = 24;
	app.changeTextPreferences.pointSize = 10;
	app.documents.item(0).changeText();
	//Clear the find/change preferences after the search.
	app.findTextPreferences = NothingEnum.nothing;
	app.changeTextPreferences = NothingEnum.nothing;
	//</fragment>
}
function myTeardown(){
}