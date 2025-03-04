//HelloWorld.jsx
//Create a new document.
var myDocument = app.documents.add();
//Get a reference to the first page.
var myPage = myDocument.pages.item(0);
//Create a text frame.
var myTextFrame = myPage.textFrames.add();
//Specify the size and shape of the text frame.
myTextFrame.geometricBounds = ["6p0", "6p0", "18p0", "18p0"];
//Enter text in the text frame.
myTextFrame.contents = "Hello World!";

//Save the document (fill in a valid file path).
var myFile = new File("/c/ServerTestFiles/HelloWorld.indd");
var result = "saved to:  " + myFile.fullName;
if(!myFile.parent.exists && !myFile.parent.create()) {
	result = "Not saved.  Unable to create the folder:  " + myFile.parent.fullName;
} else {
	myDocument = myDocument.save(myFile);
}
//Close the document.
myDocument.close();

result;