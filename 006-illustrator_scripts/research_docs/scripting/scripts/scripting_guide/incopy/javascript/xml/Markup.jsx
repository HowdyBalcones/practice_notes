//Markup.jsx
//An InCopy JavaScript
//
//Shows how to use the markup method.
main();
function main(){
    mySetup();
    mySnippet();
    myTeardown();
}
function mySetup(){
	var myDocument = app.documents.add();
	var myRootXMLElement = myDocument.xmlElements.item(0);
	var myStory = myDocument.stories.item(0);
	myStory.placeXML(myRootXMLElement);
	myString = "This is the first paragraph in a story.\r";
	myString += "This is the second paragraph in a story.\r";
	myString += "This is the third paragraph in a story.\r";
	myString += "This is the fourth paragraph in a story.\r";
	myStory.contents = myString;
	var myXMLTag = myDocument.xmlTags.add("myXMLlement");
	var myXMLElement = myRootXMLElement.xmlElements.add(myXMLTag);
}
function mySnippet(){
    //<fragment>
	var myDocument = app.documents.item(0);
	var myXMLElement= myDocument.xmlElements.item(0).xmlElements.item(0);
	var myStory = myDocument.stories.item(0);
	myStory.paragraphs.item(2).markup(myXMLElement);
    //</fragment>
}
function myTeardown(){
}