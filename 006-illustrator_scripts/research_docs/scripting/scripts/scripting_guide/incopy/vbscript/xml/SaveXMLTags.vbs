Rem SaveXMLTags.vbs
Rem An InCopy VBScript
Rem
Rem Saves a set of XML tags to a file.
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
	Set myXMLTagA = myDocument.XMLTags.Add
	myXMLTagA.Name = "XMLTagA"
	Set myXMLTagB = myDocument.XMLTags.Add
	myXMLTagB.Name = "XMLTagB"
	Set myXMLTagC = myDocument.XMLTags.Add
	myXMLTagC.Name = "XMLTagC"
	myDocument.SaveXMLTags "c:\xml_tags.xml", "Tag set created August 31, 2008"
End Function
Function myTeardown(myInCopy)
End Function
