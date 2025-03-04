//HelloWorld.jsx
//An InDesign JavaScript
//
//Creates a new document, adds a text frame, 
//resizes the text frame, and adds text.
var myDocument = app.documents.add();
var myTextFrame = myDocument.pages.item(0).textFrames.add();
myTextFrame.geometricBounds = ["6p", "6p", "24p", "24p"];
myTextFrame.contents = "Hello World!";