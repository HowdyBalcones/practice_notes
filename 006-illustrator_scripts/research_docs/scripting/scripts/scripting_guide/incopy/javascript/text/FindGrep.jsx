//FindGrep.jsx
//An InCopy JavaScript
//
//Shows how to use regular expressions (i.e., "grep") to find and change text.
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
	var myString = "This is an email address: someone@adobe.com or anyone@adobe.com.\r"
	myString += "This is some more copy with an email address that is not 24-points: "
	myString += "someone@adobe.com or anyone@adobe.com\rThis is even more "
	myString += "example copy in 24 point text. With an email address: someone@adobe.com.\r"
	myString += "This is copy in another paragraph.";
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
	app.findGrepPreferences = NothingEnum.nothing;
	app.changeGrepPreferences = NothingEnum.nothing;
	//Set the find options.
	app.findChangeGrepOptions.includeFootnotes = false;
	app.findChangeGrepOptions.includeHiddenLayers = false;
	app.findChangeGrepOptions.includeLockedLayersForFind = false;
	app.findChangeGrepOptions.includeLockedStoriesForFind = false;
	app.findChangeGrepOptions.includeMasterPages = false;
	//Regular expression for finding an email address.
	app.findGrepPreferences.findWhat = "(?i)[A-Z]*?@[A-Z]*?[.]...";
	//Apply the change to 24-point text only.
	app.findGrepPreferences.pointSize = 24;
	app.changeGrepPreferences.underline = true;
	app.documents.item(0).changeGrep();
	//Clear the find/change preferences after the search.
	app.findGrepPreferences = NothingEnum.nothing;
	app.changeGrepPreferences = NothingEnum.nothing;
	//</fragment>
}
function myTeardown(){
}