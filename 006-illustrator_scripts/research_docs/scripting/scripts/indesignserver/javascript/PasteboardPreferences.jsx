//PasteboardPreferences.jsx
//An InDesign Server JavaScript
//Create a new document and change the size of the pasteboard.
var myDocument = app.documents.add();
with(myDocument.pasteboardPreferences){
	//You can set the preview background color (which you’ll only see
	//in Preview mode) to any of the predefined UIColor constants...
	previewBackgroundColor = UIColors.grassGreen;
	//...or you can specify an array of RGB values (with values from 0 to 255)
	//previewBackgroundColor = Array(192, 192, 192)
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