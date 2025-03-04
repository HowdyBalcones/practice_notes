Rem LoadXMLTags.vbs
Rem An InDesign VBScript
Rem
Rem Loads a set of XML tags from a file.
main
Function main()
	Set myInDesign = CreateObject("InDesign.Application.2024")
	mySetup myInDesign
	mySnippet myInDesign
	myTeardown myInDesign
End Function
Function mySetup(myInDesign)
	Set myDocument = myInDesign.Documents.Add
End Function
Function mySnippet(myInDesign)
	Set myDocument = myInDesign.Documents.Item(1)
	Rem You'll have to fill in your own file path.
	Rem ![Load XML tags.]
	myDocument.LoadXMLTags "c:\xml_tags.xml"
	Rem ![Load XML tags.]
End Function
Function myTeardown(myInDesign)
End Function