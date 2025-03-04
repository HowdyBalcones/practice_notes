Rem ImportXMLIntoSelectedElement.vbs
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
	myDocument.ImportXML "c:\test.xml"
	Set myRootXMLElement = myDocument.XMLElements.Item(1)
	Set myLastXMLElement = myRootXMLElement.XMLElements.Item(-1)
	Rem Select the XML element
	myDocument.Select myLastXMLElement, idSelectionOptions.idReplaceWith
	myDocument.XMLImportPreferences.ImportToSelected = True
	Rem You'll have to fill in your own file path.
	myDocument.ImportXML "c:\test.xml"
End Function
Function myTeardown(myInCopy)
End Function

