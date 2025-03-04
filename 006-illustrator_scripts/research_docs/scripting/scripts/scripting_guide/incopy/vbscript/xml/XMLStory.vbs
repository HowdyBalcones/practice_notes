Rem XMLStory.vbs
Rem An InCopy VBScript
Rem
Rem Shows how to work with text in XML elements that have
Rem not yet been placed in a layout.
main
function main()
	Set myInCopy = CreateObject("InCopy.Application.2024")
	mySetup myInCopy
	mySnippet myInCopy
	myTeardown myInCopy
End Function
function mySetup(myInCopy)
	Set myDocument = myInCopy.Documents.Add
	Set myRootXMLElement = myDocument.xmlElements.item(1)
	Set myXMLTag = myDocument.xmlTags.add("xml_element")
	Set myXMLElementA = myRootXMLElement.xmlElements.add(myXMLTag)
	myXMLElementA.contents = "This is a paragraph in an XML story."
	Set myXMLElementB = myRootXMLElement.xmlElements.add(myXMLTag)
	myXMLElementB.contents = "This is another paragraph in an XML story."
	Set myXMLElementC = myRootXMLElement.xmlElements.add(myXMLTag)
	myXMLElementC.contents = "This is the third paragraph in an example XML story."
	Set myXMLElementD = myRootXMLElement.xmlElements.add(myXMLTag)
	myXMLElementD.contents = "This is the last paragraph in the XML story."
End Function
function mySnippet(myInCopy)
	Set myDocument = myInCopy.Documents.Item(1)
	Set myStory = myDocument.Stories.Item(1)
	Set myXMLStory = myDocument.XMLStories.Item(1)
	Rem Though the text has not yet been placed in the layout, all text
	Rem properties are available.
	myXMLStory.Paragraphs.Item(1).PointSize = 72
	Rem Place the XML so that you can see the structure.
	Set myStory = myDocument.Stories.Item(1)
	Rem Associate the root XML element with the story.
	myDocument.XMLElements.Item(1).PlaceXML myStory
End Function
Function myTeardown(myInCopy)
End Function