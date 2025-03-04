Rem HideLayersAbove.vbs
Rem An InDesign VBScript
Rem 
Rem Shows how to hide all layers in front of a given layer.
main
Function main()
	Set myInDesign = CreateObject("InDesign.Application.2024")
	mySetup myInDesign
	mySnippet myInDesign
	myTeardown myInDesign
End Function
Function mySetup(myInDesign)
	Set myDocument = myInDesign.Documents.Add
	For myCounter = 1 To 10
		myDocument.Layers.Add
	Next
	myDocument.ActiveLayer = myDocument.Layers.Item(5)
End Function
Function mySnippet(myInDesign)
	Set myDocument = myInDesign.Documents.Item(1)
	Rem ![Hide layers above.]
	Rem Given a document "myDocument"...
	Set myTargetLayer = myDocument.ActiveLayer
	Set myLayers = myDocument.Layers.ItemByRange(1, myTargetLayer.Index - 1)
	For myCounter = 1 To myLayers.Count
		myLayers.Item(myCounter).Visible = False
	Next
	Rem ![Hide layers above.]
End Function
Function myTeardown(myInDesign)
End Function