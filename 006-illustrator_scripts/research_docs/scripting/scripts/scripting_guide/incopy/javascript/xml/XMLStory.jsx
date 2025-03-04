//XMLStory.jsx
//An InCopy JavaScript
//
//Shows how to apply text formatting to unplaced XML text content.
main();
function main(){
	mySetup();
	mySnippet();
	myTeardown();
}
function mySetup(){
	var myDocument = app.documents.add();
	var myRootXMLElement = myDocument.xmlElements.item(0);
	var myXMLTag = myDocument.xmlTags.add("myXMLElement");
	var myXMLElementA = myRootXMLElement.xmlElements.add(myXMLTag);
	myXMLElementA.contents = "This is a paragraph in an XML story.";
	var myXMLElementB = myRootXMLElement.xmlElements.add(myXMLTag);
	myXMLElementB.contents = "This is another paragraph in an XML story.";
	var myXMLElementC = myRootXMLElement.xmlElements.add(myXMLTag);
	myXMLElementC.contents = "This is the third paragraph in an example XML story.";
	var myXMLElementD = myRootXMLElement.xmlElements.add(myXMLTag);
	myXMLElementD.contents = "This is the last paragraph in the XML story.";
}
function mySnippet(){
	var myDocument = app.documents.item(0);
	var myXMLStory = myDocument.xmlStories.item(0);
	//Though the text has not yet been placed in the layout, all text
	//properties are available.
	myXMLStory.texts.item(0).pointSize = 72;
	//Place the XML element in the layout to see the result.
	var myRootXMLElement = myDocument.xmlElements.item(0);
	myDocument.stories.item(0).placeXML(myRootXMLElement);
}
function myTeardown(){
}