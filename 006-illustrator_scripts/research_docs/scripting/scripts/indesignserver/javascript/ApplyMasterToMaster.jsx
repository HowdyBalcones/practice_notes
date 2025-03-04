//ApplyMasterToMaster.jsx
//An InDesign Server JavaScript
//Applies a master page to a master page.
//Assumes that the default master spread name is "A-Master".

var myDocument = app.documents.add();

//Create a new master spread.
var myBMaster = myDocument.masterSpreads.add();
myBMaster.namePrefix = "B";
myBMaster.baseName = "Master";

//Apply master spread "A" to the first page of the new master spread.
myDocument.masterSpreads.item("B-Master").pages.item(0).appliedMaster = myDocument.masterSpreads.item("A-Master")

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