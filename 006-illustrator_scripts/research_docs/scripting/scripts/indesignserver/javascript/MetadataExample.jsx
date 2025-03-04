//MetadataExample.jsx
//An InDesign Server JavaScript
//Adds metadata to an example document.
var myDocument = app.documents.add();
with(myDocument.metadataPreferences){
	author = "Olav Martin Kvern";
	copyrightInfoURL = "http://www.adobe.com";
	copyrightNotice = "This document is copyrighted.";
	copyrightStatus = CopyrightStatus.yes;
	description = "Example of xmp metadata scripting in InDesign";
	documentTitle = "XMP Example";
	jobName = "XMP_Example_2004";
	keywords = ["animal", "mineral", "vegetable"];
	//The metadata preferences object also includes the read-only
	//creator, format, creationDate, modificationDate, and serverURL properties
	//that are automatically entered and maintained by InDesign Server.
	//Create a custom XMP container, "email"
	var myNewContainer = createContainerItem("http://ns.adobe.com/xap/1.0/", "email");
	setProperty("http://ns.adobe.com/xap/1.0/", "email/*[1]", "okvern@adobe.com");
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