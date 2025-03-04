//ImportXMLIntoElement.jsx
//An InCopy JavaScript
//
//Imports an XML element into an XML element.
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
	myDocument.exportFile("XML", File(Folder.desktop + "/test.xml"));
}
function mySnippet(){
	//<fragment>
	var myDocument = app.documents.item(0);
	myDocument.importXML(File(Folder.desktop + "/test.xml"));
	var myRootXMLElement = myDocument.xmlElements.item(0);
	var myLastXMLElement = myRootXMLElement.xmlElements.item(-1);
	//Select the XML element
	myDocument.select(myLastXMLElement, SelectionOptions.replaceWith);
	myDocument.xmlImportPreferences.importToSelected = true;
	myDocument.importXML(File(Folder.desktop + "/test.xml"));
	myDocument.stories.item(0).placeXML(myRootXMLElement);
	//</fragment>
}
function myTeardown(){
}