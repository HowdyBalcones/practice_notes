//BleedAndSlug.jsx
//An InDesign Server JavaScript

//Create a new document.
var myDocument = app.documents.add();

//The bleed and slug properties belong to the documentPreferences object.
with(myDocument.documentPreferences){
	//Bleed
	documentBleedBottomOffset = "3p";
	documentBleedTopOffset = "3p";
	documentBleedInsideOrLeftOffset = "3p";
	documentBleedOutsideOrRightOffset = "3p";
	//Slug
	slugBottomOffset = "18p";
	slugTopOffset = "3p";
	slugInsideOrLeftOffset = "3p";
	slugRightOrOutsideOffset = "3p";
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