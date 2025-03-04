//ConvertAttributeToElement.jsx
//An InCopy JavaScript
//
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
	myXMLElementA.contents = "A";
	var myXMLElementB = myRootXMLElement.xmlElements.add(myXMLTag);
	myXMLElementB.contents = "B";
	var myXMLElementC = myRootXMLElement.xmlElements.add(myXMLTag);
	myXMLElementC.contents = "C";
	var myXMLElementD = myRootXMLElement.xmlElements.add(myXMLTag);
	myXMLElementD.contents = "D";
	myXMLElementB.xmlAttributes.add("example_attribute", "This is an XML attribute.");
}
function mySnippet(){
	var myDocument = app.documents.item(0);
	var myRootXMLElement = myDocument.xmlElements.item(0);
	var myXMLElementB = myRootXMLElement.xmlElements.item(1);
	myXMLElementB.xmlAttributes.item(0).convertToElement(XMLElementLocation.elementEnd, myDocument.xmlTags.item("myXMLElement"));
	//Place the XML element so that you can see the result.
	myDocument.stories.item(0).placeXML(myRootXMLElement);
}
function myTeardown(){
}