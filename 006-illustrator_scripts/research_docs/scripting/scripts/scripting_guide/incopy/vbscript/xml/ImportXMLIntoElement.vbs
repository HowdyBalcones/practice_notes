Rem ImportXMLIntoElement.vbs
Rem An InCopy VBScript
Rem
Rem Imports XML into a specific element in the XML structure.
main
Function main()
	Set myInCopy = CreateObject("InCopy.Application.2024")
	mySetup myInCopy
	mySnippet myInCopy
	myTeardown myInCopy
End Function
Function mySetup(myInCopy)
End Function
Function mySnippet(myInCopy)
	Set myDocument = myInCopy.Documents.Add
	Set myXMLTag = myDocument.XMLTags.Add("xml_element")
	Set myRootXMLElement = myDocument.XMLElements.Item(1)
	set myMXLElement = myRootXMLElement.XMLElements.Add(myXMLTag)
	Rem You'll have to fill in your own file path.
	myRootXMLElement.ImportXML "c:\completeDocument.xml"
End Function
Function myTeardown(myInCopy)
End Function

