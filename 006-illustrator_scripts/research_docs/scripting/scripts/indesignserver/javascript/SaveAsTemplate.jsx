//SaveAsTemplate.jsx
//An InDesign Server JavaScript
//Save the current document as a template.

var result = "No documents are open.";
if(app.documents.length > 0) {

	var myFileName = "/c/ServerTestFiles/myTestDocument.indt";

	var myDocument = app.documents.item(0);
	if(myDocument.saved){
		myFileName = myDocument.fullName.fullName;
		//If the file name contains the extension ".indd", change it to ".indt".
		if(myFileName.indexOf(".indd") != -1){
			var myRegularExpression = /.indd/gi;
			myFileName = myFileName.replace(myRegularExpression, ".indt");
		}
	}
	var myFile = new File(myFileName);
	var result = "saved to:  " + myFile.fullName;
	if(!myFile.parent.exists && !myFile.parent.create()) {
		result = "Not saved.  Unable to create the folder:  " + myFile.parent.fullName;
	} else {
		myDocument = myDocument.save(myFile, true);
	}

	//Close the document
	myDocument.close();
}
result;