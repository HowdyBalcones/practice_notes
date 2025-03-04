//UntagXMLElement.jsx
//An InCopy JavaScript
//
//Shows how to untag an XML element.
main();
function main(){
	mySetup();
	mySnippet();
	myTeardown();
}
function mySetup(){
	var myDocument = app.documents.add();
	var myRootXMLElement = myDocument.xmlElements.item(0);
	var myXMLTag = myDocument.xmlTags.add("xml_element");
	var myXMLElementA = myRootXMLElement.xmlElements.add(myXMLTag);
	myXMLElementA.contents = "A";
	var myXMLElementB = myRootXMLElement.xmlElements.add(myXMLTag);
	myXMLElementB.contents = "B";
	var myXMLElementC = myRootXMLElement.xmlElements.add(myXMLTag);
	myXMLElementC.contents = "C";
	var myXMLElementD = myRootXMLElement.xmlElements.add(myXMLTag);
	myXMLElementD.contents = "D";
	myDocument.stories.item(0).placeXML(myRootXMLElement);
}
function mySnippet(){
	var myDocument = app.documents.item(0);
	var myXMLElement = myDocument.xmlElements.item(0).xmlElements.item(0);
	myXMLElement.untag();
}
function myTeardown(){
}