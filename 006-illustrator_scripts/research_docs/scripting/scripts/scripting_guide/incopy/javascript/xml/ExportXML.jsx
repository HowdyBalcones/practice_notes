//ExportXML.jsx
//An InCopy JavaScript
//
//Shows how to export XML.
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
	with (myXMLElementD){
		for(var myCounter = 0; myCounter < 5; myCounter++){
			with(xmlElements.add(myXMLTag)){
				contents = "D" + myCounter;
			}
		}
	}
	myDocument.stories.item(0).placeXML(myRootXMLElement);
}
function mySnippet(){
	var myDocument = app.documents.item(0);
	//Export the entire XML structure in the document.
	myDocument.exportFile("XML", File(Folder.desktop + "/completeDocumentXML.xml"));
}
function myTeardown(){
}
