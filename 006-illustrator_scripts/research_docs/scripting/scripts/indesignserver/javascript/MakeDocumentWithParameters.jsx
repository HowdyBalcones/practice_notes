//MakeDocumentWithParameters.jsx
//An InDesign Server JavaScript
//Creates a new document.
//The parameter (DocumentPreset) specifies the document preset to use.
//The following line assumes that you have defined a document preset named
//"7x9Book" (the example script DocumentPreset.jsx will create a preset
//with this name).
var myDocument = app.documents.add(app.documentPresets.item("7x9Book"));

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