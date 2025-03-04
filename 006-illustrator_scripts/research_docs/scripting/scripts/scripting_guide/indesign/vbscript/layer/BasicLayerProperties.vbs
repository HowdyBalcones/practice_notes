Rem BasicLayerProperyties.vbs
Rem An InDesign VBScript
Rem 
Rem Shows how to work with basic layer properties.
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
	Rem ![Basic layer properties.]
	Rem Given a document "myDocument" with at least two layers...
	Set myLayer = myDocument.Layers.Add
	myLayer.Name = "myLayer"
	myLayer.LayerColor = idUIColors.idCharcoal
	myLayer.IgnoreWrap = False
	myLayer.Visible = True
	Rem ![Basic layer properties.]
End Function
Function myTeardown(myInDesign)
End Function