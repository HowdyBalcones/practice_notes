Rem MakeXMLTags.vbs
Rem An InDesign VBScript
Rem
Rem Shows how to create XML tags.
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
   Rem ![Make XML tags.]
   Set myDocument = myInDesign.Documents.Item(1)
   Rem You can create an XML tag without specifying a color for the tag.
   Set myXMLTagA = myDocument.XMLTags.Add("XML_Tag_A")
   Rem You can define the highlight color of the XML tag using the UIColors enumeration...
   Set myXMLTagB = myDocument.XMLTags.Add("XML_Tag_B", idUIColors.idGray)
   Rem ...or you can provide an RGB array to set the color of the tag.
   Set myXMLTagC = myDocument.XMLTags.Add("XML_Tag_C", Array(0, 92, 128))
   Rem ![Make XML tags.]
End Function
Function myTeardown(myInDesign)
End Function