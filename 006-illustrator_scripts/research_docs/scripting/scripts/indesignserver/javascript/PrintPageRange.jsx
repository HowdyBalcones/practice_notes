//PrintPageRange.jsx
//An InDesign Server JavaScript
//Prints a page range.
//Create an example document.
var myDocument = app.documents.add();
myDocument.viewPreferences.rulerOrigin = RulerOrigin.pageOrigin;
myPageHeight = myDocument.documentPreferences.pageHeight;
myPageWidth = myDocument.documentPreferences.pageWidth;
myDocument.documentPreferences.pagesPerDocument = 10;
var myMasterSpread = myDocument.masterSpreads.item(0);
var myTextFrame = myMasterSpread.pages.item(0).textFrames.add();
myTextFrame.geometricBounds = [0, 0, myPageHeight, myPageWidth];
myTextFrame.contents = SpecialCharacters.autoPageNumber;
myTextFrame.paragraphs.item(0).justification = Justification.centerAlign;
myTextFrame.paragraphs.item(0).pointSize = 72;
myTextFrame.textFramePreferences.verticalJustification = VerticalJustification.centerAlign;
var myTextFrame = myMasterSpread.pages.item(1).textFrames.add();
myTextFrame.geometricBounds = [0, 0, myPageHeight, myPageWidth];
myTextFrame.contents = SpecialCharacters.autoPageNumber;
myTextFrame.paragraphs.item(0).justification = Justification.centerAlign;
myTextFrame.paragraphs.item(0).pointSize = 72;
myTextFrame.textFramePreferences.verticalJustification = VerticalJustification.centerAlign;
for(var myCounter = 0; myCounter < myDocument.pages.length; myCounter ++){
	myDocument.pages.item(myCounter).appliedMaster = myDocument.masterSpreads.item("A-Master");
}
//End of example document setup.
//The page range can be either PageRange.allPages or a page range string.
//A page number entered in the page range must correspond to a page
//name in the document (i.e., not the page index). If the page name is
//not found, InDesignServer will generate an error.
myDocument.printPreferences.pageRange = "1-3, 6, 9";
myDocument.print();

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