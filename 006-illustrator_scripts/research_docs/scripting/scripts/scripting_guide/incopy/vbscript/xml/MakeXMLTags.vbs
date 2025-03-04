Rem MakeXMLTags.vbs
Rem An InCopy VBScript
Rem
Rem Creates a series of XML tags.
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
	Rem You can create an XML tag without specifying a color for the tag.
	Set myXMLTagA = myDocument.XMLTags.Add("XML_tag_A")
	Rem You can define the highlight color of the XML tag using the UIColors enumeration...
	Set myXMLTagB = myDocument.XMLTags.Add("XML_tag_B", idUIColors.idGray)
	Rem ...or you can provide an RGB array to set the color of the tag.
	Set myXMLTagC = myDocument.XMLTags.Add("XML_tag_C", Array(0, 92, 128))
End Function
Function myTeardown(myInCopy)
End Function

