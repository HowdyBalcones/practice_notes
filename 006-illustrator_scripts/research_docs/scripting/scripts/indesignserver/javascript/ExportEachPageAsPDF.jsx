//ExportEachPageAsPDF.jsx
//An InDesign Server JavaScript
//Exports each page of an InDesign document as a separate PDF to
//a specified folder using the current PDF export settings.
var result = "No documents are open.";
if(app.documents.length != 0){
	var myDocument = app.documents.item(0);
	//Fill in a valid file path on your system.
	var myFolder = new Folder("/c/ServerTestFiles");
	var result = "saved to folder:  " + myFolder.fullName;
	if(!myFolder.exists && !myFolder.create()) {
		result = "Not saved.  Unable to create the folder:  " + myFile.parent.fullName;
	} else {
		myExportPages(myDocument, myFolder.fullName);
	}
}
result;

function myExportPages(myDocument, myFolderName){
	var myBaseName = myDocument.name;
	for(var myCounter = 0; myCounter < myDocument.pages.length; myCounter ++){
		myPageName = myDocument.pages.item(myCounter).name;
		app.pdfExportPreferences.pageRange = myPageName;
		//Generate a file path from the folder name, the base document name, and the page name.
		//Replace the colons in the page name (e.g., "Sec1:1") wtih underscores.
		var myRegExp = new RegExp(":","gi");
		myPageName = myPageName.replace(myRegExp, "_");
		myFilePath = myFolderName + "/" + myBaseName + "_" + myPageName + ".pdf";
		myFile = new File(myFilePath);
		myDocument.exportFile(ExportFormat.pdfType, myFile);
	}
}