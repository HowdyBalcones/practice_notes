//DocumentPreferences.jsx
//An InDesign Server JavaScript
//Use the documentPreferences object to change the
//dimensions and orientation of the document.

var myDocument = app.documents.add();
with(myDocument.documentPreferences){
	pageHeight = "800pt";
	pageWidth = "600pt";
	pageOrientation = PageOrientation.landscape;
	pagesPerDocument = 16;
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