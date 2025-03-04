Rem ExportXML.vbs
Rem An InCopy VBScript
Rem
Rem Shows how to export XML from a document.
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
	With myXMLElementD
		For myCounter = 1 To 5
			With .xmlElements.add(myXMLTag)
				.Contents = "D" & CStr(myCounter)
			End With
		Next
	End With
	Rem Place the XML so that you can see the structure.
	Set myStory = myDocument.Stories.Item(1)
	Rem Associate the root XML element with the story.
	myRootXMLElement.PlaceXML myStory
End Function
Function mySnippet(myInCopy)
	Set myDocument = myInCopy.documents.item(1)
	Rem Export the entire XML structure in the document.
	myDocument.export "XML", "c:\completeDocument.xml"
End Function
Function myTeardown(myInCopy)
End Function