Rem LoadXMLTags.vbs
Rem An InCopy VBScript
Rem
Rem Loads a set of XML tags from a file.
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
	Rem You'll have to fill in your own file path.
	myDocument.LoadXMLTags "c:\xml_tags.xml"
End Function
Function myTeardown(myInCopy)
End Function

