//Guides.jsx
//An InDesign Server JavaScript
//Create a new document, add guides, and set guide properties.
var myDocument = app.documents.add();
myPageWidth = myDocument.documentPreferences.pageWidth;
myPageHeight = myDocument.documentPreferences.pageHeight;
with(myDocument.pages.item(0)){
	var myMarginPreferences = marginPreferences;
	//Place guides at the margins of the page.
	with(guides.add()){
		orientation = HorizontalOrVertical.vertical;
		location = myMarginPreferences.left;
	}
	with(guides.add()){
		orientation = HorizontalOrVertical.vertical;
		location = myMarginPreferences.right;
	}
	with(guides.add()){
		orientation = HorizontalOrVertical.horizontal;
		location = myMarginPreferences.top;
	}
	with(guides.add()){
		orientation = HorizontalOrVertical.horizontal;
		location = myMarginPreferences.bottom;
	}
	//Place a guide at the vertical center of the page.
	with(guides.add()){
		orientation = HorizontalOrVertical.vertical;
		location = myPageWidth/2;
	}
	//Place a guide at the horizontal center of the page.
	with(guides.add()){
		orientation = HorizontalOrVertical.horizontal;
		location = myPageHeight/2;
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
