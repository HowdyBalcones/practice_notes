Rem MoveXMLElement.vbs
Rem An InCopy VBScript
Rem
Rem Moves an XML element in the XML structure.
main
Function main()
	Set myInCopy = CreateObject("InCopy.Application.2024")
	mySetup myInCopy
	mySnippet myInCopy
	myTeardown myInCopy
End Function
Function mySetup(myInCopy)
	Set myDocument = myInCopy.documents.add
	Set myRootXMLElement = myDocument.xmlElements.item(1)
	Set myXMLTag = myDocument.xmlTags.add("xml_element")
	Set myXMLElementA = myRootXMLElement.xmlElements.add(myXMLTag)
	myXMLElementA.contents = "A"
	Set myXMLElementB = myRootXMLElement.xmlElements.add(myXMLTag)
	myXMLElementB.contents = "B"
	Set myXMLElementC = myRootXMLElement.xmlElements.add(myXMLTag)
	myXMLElementC.contents = "C"
	Set myXMLElementD = myRootXMLElement.xmlElements.add(myXMLTag)
	myXMLElementD.contents = "D"
End Function
Function mySnippet(myInCopy)
	Set myDocument = myInCopy.documents.item(1)
	Set myRootXMLElement = myDocument.xmlElements.item(1)
	Rem Move the XML element containing "A" to after the XML element containing "C"
	Set myXMLElementA = myRootXMLElement.xmlElements.item(1)
	myXMLElementA.move idLocationOptions.idAfter, myRootXMLElement.xmlElements.item(3)
	Rem Move the XML element containing "D" to the beginning of its parent.
	myRootXMLElement.xmlElements.item(-1).move idLocationOptions.idAtBeginning
	Rem Place the XML so that you can see the structure.
	Set myStory = myDocument.Stories.Item(1)
	Rem Associate the root XML element with the story.
	myRootXMLElement.PlaceXML myStory
End Function
Function myTeardown(myInCopy)
End Function