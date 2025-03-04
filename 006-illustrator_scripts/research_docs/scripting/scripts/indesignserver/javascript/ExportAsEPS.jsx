//ExportAsEPS.jsx
//An InDesign Server JavaScript.
//Exports the pages of the current document as a series of EPS files.
var result = "No documents are open.";
if(app.documents.length != 0){
	//Fill in a valid file path for your system.
	var myFile = new File("/c/ServerTestFiles/myTestDocument.eps");
	var result = "saved to:  " + myFile.fullName;
	if(!myFile.parent.exists && !myFile.parent.create()) {
		result = "Not saved.  Unable to create the folder:  " + myFile.parent.fullName;
	} else {
		app.documents.item(0).exportFile(ExportFormat.epsType, myFile);
	}
}

result;