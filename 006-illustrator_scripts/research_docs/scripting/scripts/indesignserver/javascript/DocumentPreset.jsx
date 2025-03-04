//DocumentPreset.jsx
//An InDesign Server JavaScript
//Creates a new document preset.
//If the document preset "7x9Book" does not already exist, create it.
try{
	myDocumentPreset = app.documentPresets.item("7x9Book");
	myDocumentPreset.name;
}
catch(myError){
	myDocumentPreset = app.documentPresets.add();
	myDocumentPreset.name = "7x9Book";
}
//Fill in the properties of the document preset.
with(myDocumentPreset){
	pageHeight = "9i";
	pageWidth = "7i";
	left = "4p";
	right = "6p";
	top = "4p";
	bottom = "9p";
	columnCount = 1;
	documentBleedBottomOffset = "3p";
	documentBleedTopOffset = "3p";
	documentBleedInsideOrLeftOffset = "3p";
	documentBleedOutsideOrRightOffset = "3p";
	facingPages = true;
	pageOrientation = PageOrientation.portrait;
	pagesPerDocument = 1;
	slugBottomOffset = "18p";
	slugTopOffset = "3p";
	slugInsideOrLeftOffset = "3p";
	slugRightOrOutsideOffset = "3p";
}
