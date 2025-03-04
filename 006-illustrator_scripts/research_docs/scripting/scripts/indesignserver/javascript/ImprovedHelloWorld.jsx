//ImprovedHello World.jsx
var myDocument = app.documents.add();
var myPage = myDocument.pages.item(0);
var myTextFrame = myPage.textFrames.add();
myTextFrame.contents = "Hello World!";
//Get page width and page height using the function "myGetBounds".
myBounds = myGetBounds(myDocument, myPage);
//Resize the text frame to match the publication margins.
myTextFrame.geometricBounds = myBounds;
var myParagraph = myTextFrame.paragraphs.item(0);
//Change the font, size, and alignment.
//Enter the name of a font on your system, if necessary.
try {
	var myFont = app.fonts.item("Arial");
	myParagraph.appliedFont = myFont;
}
catch (e){}
//Change the size of the text.
myParagraph.pointSize = 48;
//Set the justification of the paragraph to center align.
myParagraph.justification = Justification.centerAlign
//Set the first baseline offset of the text frame to ascent.
myTextFrame.textFramePreferences.firstBaselineOffset = FirstBaseline.ascentOffset;
//Set the vertical justification of the text frame to center.
myTextFrame.textFramePreferences.verticalJustification = VerticalJustification.centerAlign;
//Export the document as PDF (fill in a valid file path).
myDocument.exportFile(ExportFormat.pdfType, new File("/c/ImprovedHelloWorld.pdf"));
//Close the document.
app.documents.item(0).close();
function myGetBounds(myDocument, myPage){
	var myPageHeight = myDocument.documentPreferences.pageHeight;
	var myPageWidth = myDocument.documentPreferences.pageWidth;
	var myTop = myPage.marginPreferences.top;
	var myLeft = myPage.marginPreferences.left;
	var myRight = myPage.marginPreferences.right;
	var myBottom = myPage.marginPreferences.bottom;
	myRight = myPageWidth - myRight;
	myBottom = myPageHeight - myBottom;
	return [myTop, myLeft, myBottom, myRight];
}
