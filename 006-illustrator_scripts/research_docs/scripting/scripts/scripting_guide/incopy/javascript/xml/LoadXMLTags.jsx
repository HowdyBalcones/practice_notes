//LoadXMLTags.jsx
//An InCopy JavaScript
//
//Loads a set of XML tags from a file.
main();
function main(){
    mySetup();
    mySnippet();
    myTeardown();
}
function mySetup(){
	var myDocument = app.documents.add();
	var myXMLTag = myDocument.xmlTags.add("xml_elementA");
	var myXMLTag = myDocument.xmlTags.add("xml_elementB");
	var myXMLTag = myDocument.xmlTags.add("xml_elementC");
	myDocument.saveXMLTags(File(Folder.desktop + "/xml_tags.xml"));
	myDocument.close(SaveOptions.no);
}
function mySnippet(){
    //<fragment>
    //Access the active document and page.
    var myDocument = app.documents.add();
    myDocument.loadXMLTags (File(Folder.desktop + "/xml_tags.xml"));
    //</fragment>
}
function myTeardown(){
}