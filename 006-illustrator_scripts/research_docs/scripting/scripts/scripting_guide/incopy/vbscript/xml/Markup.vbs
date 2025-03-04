Rem Markup.vbs
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
	Set myDocument = myInCopy.Documents.Add
	Set myRootXMLElement = myDocument.xmlElements.item(1)
	Set myXMLTag = myDocument.xmlTags.add("xml_element")
	Set myXMLElementA = myRootXMLElement.xmlElements.add(myXMLTag)
	myXMLElementA.contents = "This is a paragraph in an XML story."
	Set myStory = myDocument.Stories.Item(1)
	myStory.PlaceXML myRootXMLElement
	myString = "This is the first paragraph in a text frame." & vbCr
	myString = myString & "This is the second paragraph in a text frame." & vbCr
	myString = myString & "This is the third paragraph in a text frame." & vbCr
	myString = myString & "This is the fourth paragraph in a text frame." & vbCr
	myStory.contents = myString
	myRootXMLElement.XMLElements.Add myXMLTag
End Function
Function mySnippet(myInCopy)
	Set myDocument = myInCopy.documents.item(1)
	myDocument.Stories.Item(1).Paragraphs.Item(3).Markup myDocument.XMLElements.Item(1).XMLElements.Item(-1)
End Function
Function myTeardown(myInCopy)
End Function