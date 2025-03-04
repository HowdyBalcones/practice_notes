Rem ConvertAttributeToElement.vbs
Rem An InCopy VBScript
Rem
Rem Shows how to convert an XML attribute to an XML element.
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
	myXMLElementB.xmlAttributes.add "example_attribute", "This is an XML attribute. It will not appear in the layout!"
End Function
Function mySnippet(myInCopy)
	Set myDocument = myInCopy.documents.item(1)
	Set myRootXMLElement = myDocument.xmlElements.item(1)
	Set myXMLElementB = myRootXMLElement.xmlElements.item(2)
	myXMLElementB.xmlAttributes.item(1).convertToElement idXMLElementLocation.idElementEnd, myDocument.xmlTags.item("xml_element")
	Set myStory = myDocument.Stories.Item(1)
	myRootXMLElement.PlaceXML myStory
End Function
Function myTeardown(myInCopy)
End Function