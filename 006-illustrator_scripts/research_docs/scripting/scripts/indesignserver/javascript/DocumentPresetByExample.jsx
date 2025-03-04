//DocumentPresetByExample.jsx
//An InDesign Server JavaScript
//Creates a document preset based on the current document settings.
//Assumes you have a document open.
var result = "No documents are open.";
if(app.documents.length != 0){
	result = "success";
	var myDocument = app.documents.item(0);
	var myDocumentPrefs = myDocument.documentPreferences;
	//If the document preset "myDocumentPreset" does not already exist, create it.
	//Disable normal error handling.
	try{
		myDocumentPreset = app.documentPresets.item("myDocumentPreset");
		myDocumentPreset.name;
	}
	catch(myError){
	//If the document preset did not exist, the above line
	//generates an error. Handle the error.
		myDocumentPreset = app.documentPresets.add();
		myDocumentPreset.name = "myDocumentPreset";
	}
	//Fill in the properties of the document preset with the corresponding
	//properties of the active document.
	with(myDocumentPreset){
		left = myDocument.marginPreferences.left;
		right = myDocument.marginPreferences.right;
		top = myDocument.marginPreferences.top;
		bottom = myDocument.marginPreferences.bottom;
		columnCount = myDocument.marginPreferences.columnCount;
		columnGutter = myDocument.marginPreferences.columnGutter;
		documentBleedBottomOffset = myDocumentPrefs.documentBleedBottomOffset;
		documentBleedTopOffset = myDocumentPrefs.documentBleedTopOffset;
		documentBleedInsideOrLeftOffset = myDocumentPrefs.documentBleedInsideOrLeftOffset;
		documentBleedOutsideOrRightOffset = myDocumentPrefs.documentBleedOutsideOrRightOffset;
		facingPages = myDocument.documentPreferences.facingPages;
		pageHeight = myDocument.documentPreferences.pageHeight;
		pageWidth = myDocument.documentPreferences.pageWidth;
		pageOrientation = myDocument.documentPreferences.pageOrientation;
		pagesPerDocument = myDocument.documentPreferences.pagesPerDocument;
		slugBottomOffset = myDocument.documentPreferences.slugBottomOffset;
		slugTopOffset = myDocument.documentPreferences.slugTopOffset;
		slugInsideOrLeftOffset = myDocument.documentPreferences.slugInsideOrLeftOffset;
		slugRightOrOutsideOffset = myDocument.documentPreferences.slugRightOrOutsideOffset;
	}
}

result;