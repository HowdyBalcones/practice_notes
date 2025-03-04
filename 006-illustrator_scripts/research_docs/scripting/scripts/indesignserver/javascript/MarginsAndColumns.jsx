//MarginsAndColumns.jsx
//An InDesign Server JavaScript
//Sets up the margins and columns for the first page of an example document.
var myDocument = app.documents.add();
with(myDocument.pages.item(0).marginPreferences){
	columnCount = 3;
	//columnGutter can be a number or a measurement string.
	columnGutter = "1p";
	top = "4p";
	bottom = "6p";
	//When document.documentPreferences.facingPages = true,
	//"left" means inside "right" means outside.
	left = "6p";
	right = "4p";
}
//Save the file (fill in a valid file path on your system).
var myFile = new File("/c/ServerTestFiles/myTestDocument.indd");
var result = "saved to:  " + myFile.fullName;
if(!myFile.parent.exists && !myFile.parent.create()) {
	result = "Not saved.  Unable to create the folder:  " + myFile.parent.fullName;
} else {
	myDocument = myDocument.save(myFile);
}
//Close the document
myDocument.close();

result;