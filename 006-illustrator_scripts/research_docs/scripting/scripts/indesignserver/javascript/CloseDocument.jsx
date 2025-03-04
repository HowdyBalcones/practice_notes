//CloseDocument.jsx
//An InDesign Server CCJavaScript
//Closes the current document.
if(app.documents.length != 0){
	app.documents.item(0).close();
} else {
	var result = "No documents are open.";
	result;
}