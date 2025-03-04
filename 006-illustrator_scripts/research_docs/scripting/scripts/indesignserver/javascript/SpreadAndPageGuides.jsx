//SpreadAndPageGuides.jsx
//An InDesign Server JavaScript
//Demonstrates the difference between spread guides and page guides.
var myDocument = app.documents.add();
myDocument.documentPreferences.facingPages = true;
myDocument.documentPreferences.pagesPerDocument = 3;
with(myDocument.spreads.item(1)){
	//Note the difference between these two guides on pages 2 and 3.
	with(guides.add()){
		orientation = HorizontalOrVertical.horizontal;
		location = "6p";
		fitToPage = true;
	}
	with(guides.add()){
		orientation = HorizontalOrVertical.horizontal;
		location = "9p";
		fitToPage = false;
	}
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