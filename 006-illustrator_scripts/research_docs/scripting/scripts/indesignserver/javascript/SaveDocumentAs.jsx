//SaveDocumentAs.jsx
//An InDesign Server JavaScript
//Save the active document to the specified file name.

var result = "No documents are open.";
if(app.documents.length > 0) 
{
	var myDocument = app.documents.item(0);

	// saveAs file path	(replace with valid one for your system)
	var myFile = new File("/c/ServerTestFiles/myTestDocument.indd");
	result = "saved to:  " + myFile.fullName;
	if(!myFile.parent.exists && !myFile.parent.create()) {
		result = "Not saved.  Unable to create the folder:  " + myFile.parent.fullName;
	} else {
		myDocument = myDocument.save(myFile);
		// note: the object myDocument pointed to before save() is no longer valid, so 
		// you must reassign myDocument to the result of save().
	}
}

result;
