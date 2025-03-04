//FontCollections.jsx
//An InCopy JavaScript
//
//Shows the difference between the fonts collection of the application
//and the fonts collection of a document.
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
	var myApplicationFonts = app.fonts;
	var myDocument = app.documents.add();
	var myStory = myDocument.stories.item(0);
	var myDocumentFonts = myDocument.fonts;
	var myFontNames = myApplicationFonts.everyItem().name;
	if(myDocumentFonts.length > 0){
		var myDocumentFontNames = myDocumentFonts.everyItem().name;
		var myString = "Document Fonts:\r";
		for(var myCounter = 0;myCounter<myDocumentFontNames.length; myCounter++){
			myString += myDocumentFontNames[myCounter] + "\r";
		}
	}
	myString += "\rApplication Fonts:\r";
	for(var myCounter = 0;myCounter<myFontNames.length; myCounter++){
		myString += myFontNames[myCounter] + "\r";
	}
	myStory.contents = myString;
//	//</fragment>
}
function myTeardown(){
}
