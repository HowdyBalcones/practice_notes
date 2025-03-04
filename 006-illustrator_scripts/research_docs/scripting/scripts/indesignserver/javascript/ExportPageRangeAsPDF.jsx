//ExportPageRangeAsPDF.jsx
//An InDesign Server JavaScript.
//Exports a range of pages to a PDF file.
//Enter the names of the pages you want to export in the following line.
//Note that the page name is not necessarily the index of the page in the
//document (e.g., the first page of a document whose page numbering starts
//with page 21 will be "21", not 1).
//Create an example document.
var myDocument = app.documents.add();
myDocument.viewPreferences.rulerOrigin = RulerOrigin.pageOrigin;
myDocument.documentPreferences.pagesPerDocument = 12;
var myMasterSpread = myDocument.masterSpreads.item(0);
for(myCounter = 0; myCounter < myMasterSpread.pages.length; myCounter ++){
	var myTextFrame = myMasterSpread.pages.item(myCounter).textFrames.add();
	myTextFrame.move(undefined, [1, 1]);
	myTextFrame.contents = SpecialCharacters.autoPageNumber;
	myTextFrame.paragraphs.item(0).pointSize = 72;
	myTextFrame.paragraphs.item(0).justification = Justification.centerAlign;
	myTextFrame.textFramePreferences.firstBaselineOffset = FirstBaseline.ascentOffset;
	myTextFrame.textFramePreferences.verticalJustification = VerticalJustification.centerAlign;
	myTextFrame.geometricBounds = myGetBounds(myDocument, myMasterSpread.pages.item(myCounter));
}
//End example document setup.
app.pdfExportPreferences.pageRange = "1-3, 6, 9";

//Fill in your own file path.
var myFile = new File("/c/ServerTestFiles/myTestDocument.pdf");
var result = "saved to:  " + myFile.fullName;
if(!myFile.parent.exists && !myFile.parent.create()) {
	result = "Not saved.  Unable to create the folder:  " + myFile.parent.fullName;
} else {
	app.documents.item(0).exportFile(ExportFormat.pdfType, myFile);
}

result;


function myGetBounds(myDocument, myPage){
	myPageWidth = myDocument.documentPreferences.pageWidth;
	myPageHeight = myDocument.documentPreferences.pageHeight;
	var myMarginPreferences = myPage.marginPreferences;
	myLeft = myMarginPreferences.left;
	myTop = myMarginPreferences.top;
	myRight = myPageWidth - myMarginPreferences.right;
	myBottom = myPageHeight - myMarginPreferences.bottom;
	return [myTop, myLeft, myBottom, myRight];
}