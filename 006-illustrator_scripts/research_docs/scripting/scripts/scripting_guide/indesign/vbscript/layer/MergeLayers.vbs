Rem MergeLayers.vbs
Rem An InDesign VBScript
Rem 
Rem Merge layer
main
Function main()
	Set myInDesign = CreateObject("InDesign.Application.2024")
	mySetup myInDesign
	mySnippet myInDesign
	myTeardown myInDesign
End Function
Function mySetup(myInDesign)
	Set myDocument = myInDesign.Documents.Add
	myDocument.Layers.Add
End Function
Function mySnippet(myInDesign)
	Set myDocument = myInDesign.Documents.Item(1)
	Rem ![Merge layers.]
	Rem Given a document "myDocument" containing at least two layers...
	Set myLayerA = myDocument.Layers.Item(1)
	Set myLayerB = myDocument.Layers.Item(2)
    myLayerA.Merge(myLayerB)
    Rem ![Merge layers.]
End Function
Function myTeardown(myInDesign)
End Function