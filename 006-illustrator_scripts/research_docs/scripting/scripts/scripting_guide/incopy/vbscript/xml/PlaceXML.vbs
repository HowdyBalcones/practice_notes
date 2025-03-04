Rem PlaceXML.vbs
Rem An InCopy VBScript
Rem 
main
Function main()
	Set myInCopy = CreateObject("InCopy.Application.2024")
	mySetup myInCopy
	mySnippet myInCopy
	myTeardown myInCopy
End Function
Function mySetup(myInCopy)
	Set myDocument = myInCopy.documents.Add
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
Function mySnippet(myInCopy)
	Set myDocument = myInCopy.documents.item(1)
	Rem Place the XML so that you can see the structure.
	Set myStory = myDocument.Stories.Item(1)
	Rem Associate the root XML element with the story.
	Set myRootXMLElement = myDocument.xmlElements.item(1)
	myRootXMLElement.PlaceXML myStory
End Function
Function myTeardown(myInCopy)
End Function
