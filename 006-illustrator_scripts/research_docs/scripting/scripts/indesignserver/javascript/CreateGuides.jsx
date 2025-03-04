//CreateGuides.jsx
//An InDesign Server JavaScript
//Add a series of guides using the createGuides method.

var myDocument = app.documents.add();

//Parameters (all optional): row count, column count, row gutter,
//column gutter,guide color, fit margins, remove existing, layer.
//Note that the createGuides method does not take an RGB array
//for the guide color parameter.
myDocument.spreads.item(0).createGuides(4, 4, "1p", "1p", UIColors.gray, true, true, myDocument.layers.item(0));

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