//UniformSlug.jsx
//An InDesign Server JavaScript
//Create a new document.
var myDocument = app.documents.add();
//The slug properties belong to the documentPreferences object.
with(myDocument.documentPreferences){
	//Slug:
	slugTopOffset = "3p";
	documentSlugUniformSize = true;
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