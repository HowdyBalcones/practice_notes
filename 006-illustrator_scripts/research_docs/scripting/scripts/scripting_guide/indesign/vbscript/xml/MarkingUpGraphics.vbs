Rem MarkingUpGraphics.vbs
Rem An InDesign VBScript
Rem
Rem Shows how to associate a graphic with an XML element.
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
	Set myPage = myDocument.Pages.Item(1)
	Rem ![Marking up graphics.]
	Set myXMLTag = myDocument.XMLTags.Add("graphic")
	Set myGraphic = myPage.Place("c:\test.tif")
	Rem The place method returns a collection. We placed a single graphic,
	Rem so get the first item in the collection.
	Set myGraphic = myGraphic.Item(1)
	Set myXMLElement = myDocument.XMLElements.Item(1).XMLElements.Add(myXMLTag)
	Rem the parent of the graphic is the graphic frame.
	myGraphic.parent.markup myXMLElement
	Rem You can also associate the graphic with a new XML element as you create the element.
	Rem Set myXMLElement = myDocument.XMLElements.Item(1).XMLElements.Add(myXMLTag, myGraphic)
	Rem ![Marking up graphics.]
End Function
Function myTeardown(myInDesign)
End Function