//SaveDocument.jsx
//An InDesign Server JavaScript
//If the active document has been changed since it was last saved, save it.

var result = "No documents are open.";
if(app.documents.length > 0) 
{
	var myDocument = app.documents.item(0);
	if(myDocument.modified){
		myDocument = myDocument.save();
		result = "saved to: " + myDocument.fullName;
	} else {
		result = "Document not saved because it hasn't been modified.";
	}
}

result;