//BleedSlugGuideColors.jsx
//An InDesign Server JavaScript
//Set the colors used to display the bleed and slug guides.

var myDocument = app.documents.add();

//Set the bleed and slug properties.
with(myDocument.documentPreferences){
	//Bleed
	documentBleedTopOffset = "3p";
	documentBleedUniformSize = true;
	//Slug (large slug area at bottom provides room for
	//comments, tracking information, etc.)
	slugBottomOffset = "18p";
	slugTopOffset = "3p";
	slugInsideOrLeftOffset = "3p";
	slugRightOrOutsideOffset = "3p";
}
with(myDocument.pasteboardPreferences){
	//Any of InDesign Server's guides can use the UIColors constants...
	bleedGuideColor = UIColors.cuteTeal;
	slugGuideColor = UIColors.charcoal;
	//...or you can specify an array of RGB values (with values from 0 to 255)
	//bleedGuideColor = [0, 198, 192];
	//slugGuideColor = [192, 192, 192];
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