//ApplyMaster.jsx
//An InDesign Server JavaScript
//Applies a master spread to a page.

var myDocument = app.documents.add();

//Create a new master spread.
var myMasterSpread = myDocument.masterSpreads.add();

//Apply the new master spread to the first page in the document.
myDocument.pages.item(0).appliedMaster = myMasterSpread;

//When you are working with an existing document, you can refer to
//a master spread by name, for example: myDocument.MasterSpreads.Item("B-Master")

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
