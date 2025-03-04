//ReadPMTags.jsx
//An InCopy JavaScript
//
//Shows how to use regular expressions to read an imported PageMaker paragraph tags file.
//PageMaker paragraph tags (which are not the same as PageMaker tagged text format files) are a
//simplified text markup scheme. Paragraph style names appear at the start of a paragraph:
//
//<heading1>This is some text.
//<body_text>This is body text.
//
main();
function main(){
	mySetup();
	mySnippet();
	myTeardown();
}
function mySetup(){
	//Create some example marked-up text (as if it had been imported).
	var myString = "<heading1>Heading One.\r"
	myString += "<body_text>This is an example paragraph of body text.\r";
	myString += "<body_text>This is another example paragraph of body text.\r";
	myString += "<heading2>Heading Two.\r";
	myString += "<body_text>This is an example paragraph of body text.\r";
	myString += "<body_text>This is another example paragraph of body text.\r";
	myString += "<heading2>Heading Two.\r";
	myString += "<body_text>This is an example paragraph of body text.\r";
	myString += "<body_text>This is another example paragraph of body text.\r";
	//Create an example document.
	var myDocument = app.documents.add();
	var myStory = myDocument.stories.item(0);
	myStory.contents = myString;
}
function mySnippet(){
	//<fragment>
	var myDocument = app.documents.item(0);
	var myStory = myDocument.stories.item(0);
	myReadPMTags(myStory);
	//</fragment>
}
function myTeardown(){
}
//<fragment>
function myReadPMTags(myStory){
	var myName, myString, myStyle, myStyleName;
	var myDocument = myStory.parent;
	//Reset the findGrepPreferences to ensure that previous settings
	//do not affect the search.
	app.findGrepPreferences = NothingEnum.nothing;
	app.changeGrepPreferences = NothingEnum.nothing;
	//Find the tags (since this is a JavaScript string, the backslashes must be escaped).
	app.findGrepPreferences.findWhat = "(?i)^<\\s*\\w+\\s*>";
	var myFoundItems = myStory.findGrep();
	if(myFoundItems.length != 0){
		var myFoundTags = new Array;
		for(var myCounter = 0; myCounter<myFoundItems.length; myCounter++){
			myFoundTags.push(myFoundItems[myCounter].contents);
		}
		myFoundTags = myRemoveDuplicates(myFoundTags);
		//At this point, we have a list of tags to search for.
		for(myCounter = 0; myCounter < myFoundTags.length; myCounter++){
			myString = myFoundTags[myCounter];
			//Find the tag using findWhat.
			app.findTextPreferences.findWhat = myString;
			//Extract the style name from the tag.
			myStyleName = myString.substring(1, myString.length-1);
			//Create the style if it does not already exist.
			try{
				myStyle = myDocument.paragraphStyles.item(myStyleName);
				myName = myStyle.name;
			}
			catch (myError){
				myStyle = myDocument.paragraphStyles.add({name:myStyleName});
			}
			//Apply the style to each instance of the tag.
			app.changeTextPreferences.appliedParagraphStyle = myStyle;
			myStory.changeText();
			//Reset the changeTextPreferences.
			app.changeTextPreferences = NothingEnum.nothing;
			//Set the changeTo to an empty string.
			app.changeTextPreferences.changeTo = "";
			//Search to remove the tags.
			myStory.changeText();
			//Reset the find/change preferences again.
			app.changeTextPreferences = NothingEnum.nothing;			
		}
	}
	//Reset the findGrepPreferences.
	app.findGrepPreferences  = NothingEnum.nothing;
}
function myRemoveDuplicates(myArray){ 
	//Semi-clever method of removing duplicate array items; much faster 
	//than comparing every item to every other item! 
	var myNewArray = new Array; 
	myArray = myArray.sort(); 
	myNewArray.push(myArray[0]); 
	if(myArray.length > 1){ 
		for(var myCounter = 1; myCounter < myArray.length; myCounter ++){ 
			if(myArray[myCounter] != myNewArray[myNewArray.length -1]){ 
				myNewArray.push(myArray[myCounter]); 
			} 
		} 
	} 
	return myNewArray; 
}
//</fragment>
