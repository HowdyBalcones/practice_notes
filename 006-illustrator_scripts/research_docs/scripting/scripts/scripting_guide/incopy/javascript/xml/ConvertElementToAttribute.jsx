//ConvertElementToAttribute.jsx
//An InCopy JavaScript
//
//Shows how to convert an XML element to an XML attribute.
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
	var myXMLElement = myRootXMLElement.xmlElements.add(myXMLTag);
	myXMLElement.contents = "This is content in an XML element.";
}
function mySnippet(){
	var myDocument = app.documents.item(0);
	var myRootXMLElement = myDocument.xmlElements.item(0);
	myRootXMLElement.xmlElements.item(0).convertToAttribute();
	//Place the XML content so that you can see the result of the change.
	var myStory = myDocument.stories.item(0);
	myStory.placeXML(myRootXMLElement);
}
function myTeardown(){
}