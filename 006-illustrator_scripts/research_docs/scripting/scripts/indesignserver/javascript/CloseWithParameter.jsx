//CloseWithParameter.jsx
//An InDesign Server JavaScript
//Use SaveOptions.yes to save the document, or use SaveOptions.no
//to close the document without saving. If you use SaveOptions.yes,
//you’ll need to provide a reference to a file to save to in the second
//parameter (SavingIn).
//If the file has not been saved, save it to a specific file path.

var result = "No documents are open.";
if(app.documents.length > 0) 
{
	var myDocument = app.documents.item(0);
	if(!myDocument.saved){
		var myFile = new File("/c/ServerTestFiles/myTestDocument.indd");
		result = "saved to:  " + myFile.fullName;
		if(!myFile.parent.exists && !myFile.parent.create()) {
			result = "Not closed.  Unable to create the folder:  " + myFile.parent.fullName;
		} else {
			myDocument.close(SaveOptions.yes, myFile);
		}
	} else {
		result = "saved to:  " + myDocument.fullName;
		myDocument.close(SaveOptions.yes);
	}	
}

result;