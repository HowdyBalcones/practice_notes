//ImportXMLIntoSelectedElement.jsx
//An InCopy JavaScript
//
//Imports an XML element into the selected XML element.
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
	var myXMLTag = myDocument.xmlTags.item("xml_element");
	var myXMLElement = myDocument.xmlElements.item(0).xmlElements.add(myXMLTag);
	myDocument.select(myXMLElement);
	myDocument.xmlImportPreferences.importToSelected = true;
	//Import into the selected XML element.
	myDocument.importXML(File(Folder.desktop + "/test.xml"));
	myDocument.stories.item(0).placeXML(myDocument.xmlElements.item(0));
	//</fragment>
}
function myTeardown(){
}