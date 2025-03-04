//MakeXMLComment.jsx
//An InCopy JavaScript
//
//Shows how to add an XML comment.
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
	myRootXMLElement.placeXML(myDocument.stories.item(0));
}
function mySnippet(){
	var myDocument = app.documents.item(0);
	var myRootXMLElement = myDocument.xmlElements.item(0);
	var myXMLElementB = myRootXMLElement.xmlElements.item(1);
	myXMLElementB.xmlComments.add("This is an XML comment. It will not appear in the layout!");
}
function myTeardown(){
}