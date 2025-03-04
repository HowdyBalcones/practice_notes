//OpenDocument.jsx
//An InDesign Server JavaScript
//Opens an existing document. You’ll have to fill in your own file path.

var myFile = new File("/c/ServerTestFiles/myTestDocument.indd");
var folderExists = true;
var result = "";

// create the file if it does not exist
if(!myFile.exists) {
	// create the parent folder if necessary
	if(!myFile.parent.exists){ 
		folderExists = myFile.parent.create(); 
	}
	if(folderExists) {
		// create a document, save it, and close it
		var myDocument = app.documents.add();
		myDocument = myDocument.save(myFile);
		myDocument.close();
	} else {
		result = "Unable to create the folder:  " + myFile.path;
	}
}

if (folderExists) {

	// OPEN
	var myDocument = app.open(myFile);

	//Add a rectangle to the first page.
	var myRectangle = myDocument.pages.item(0).rectangles.add();
	myRectangle.geometricBounds = ["6p", "6p", "18p", "18p"];
	myRectangle.strokeWeight = 12;

	// leave the document open...

	result = myDocument.fullName;
}

result;

