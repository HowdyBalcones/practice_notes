//PrintDocument.jsx
//An InDesign Server JavaScript
//Prints the current document.
var result = "No documents are open.";
if(app.documents.length > 0){
	//The print method has one optional parameter, Using,
	//which sets the printer preset to use. The following line
	//prints the document using the default settings
	app.documents.item(0).print();
	//To print the document using a preset named "ColorProof":
	//app.documents.item(0).print("ColorProof");

	result = "success";
}

result;