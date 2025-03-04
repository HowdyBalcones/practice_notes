//ApplicationPageMargins.jsx
//An InDesign Server JavaScript
//Sets the application default page margins. All new documents
//will be created using these settings. Existing documents
//will be unaffected.
with(app.marginPreferences){
	//Save the current application default margin preferences.
	myY1 = top;
	myX1 = left;
	myY2 = bottom;
	myX2 = right;
	//Set the application default margin preferences.
	top = 0;
	left = 0;
	bottom = 0;
	right = 0;
}
//Create a new example document to demonstrate the change.
var myDocument = app.documents.add();
myDocument.documentPreferences.pageHeight = "1p";
myDocument.documentPreferences.pageWidth = "6p";

//Save the file (fill in a valid file path on your system).
var myFile = new File("/c/ServerTestFiles/myTestDocument.indd");
var result = "saved to:  " + myFile.fullName;
if(!myFile.parent.exists && !myFile.parent.create()) {
	result = "Not saved.  Unable to create the folder:  " + myFile.parent.fullName;
} else {
	// SAVE
	myDocument = myDocument.save(myFile);
}

//Close the document
myDocument.close();

//Reset the application default margin preferences to their former state.
with(app.marginPreferences){
	top = myY1;
	left = myX1;
	bottom = myY2;
	right = myX2;
}

result;