//FindChangeStringFormatting.jsx
//An InCopy CS3 JavaScript
//
//Shows how to find and change text formatting.
//
//Make an example document.
myCreateExampleDocument();
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
app.findTextPreferences.findWhat = "WIDGET^9^9^9^9";
//The following line will only work if your default font has a font style named "Bold"
//if not, change the text to a font style used by your default font.
app.changeTextPreferences.fontStyle = "Bold";
//Search the document. In this example, we'll use the 
//InDesign search metacharacter "^9" to find any digit.
var myFoundItems = app.documents.item(0).changeText();
alert("Changed " + myFoundItems.length + " instances of the search string.");
//Clear the find/change preferences after the search.
app.findTextPreferences = NothingEnum.nothing;
app.changeTextPreferences = NothingEnum.nothing;
function myCreateExampleDocument(){
	//Create an example document.
	var myDocument = app.documents.add();
	var myStory = myDocument.stories.item(0);
	var myString = "Widget A. PartNumber: WIDGET0001\rWidget B. PartNumber: WIDGET0002\rWidget C. PartNumber: WIDGET0003\rWidget D. PartNumber: WIDGET1234\r";
	myStory.contents = myString;
}