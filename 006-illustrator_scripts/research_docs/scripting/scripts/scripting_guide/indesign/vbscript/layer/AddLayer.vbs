Rem AddLayer.vbs
Rem An InDesign VBScript
Rem 
Rem Shows how to create a new layer.
main
Function main()
	Set myInDesign = CreateObject("InDesign.Application.2024")
	mySetup myInDesign
	mySnippet myInDesign
	myTeardown myInDesign
End Function
Function mySetup(myInDesign)
End Function
Function mySnippet(myInDesign)
	Rem ![Create layer.]
	Rem Given a document "myDocument"...
	Set myDocument = myInDesign.Documents.Item(1)
	Set myLayer = myDocument.layers.Add()
	Rem ![Create layer.]
End Function
Function myTeardown(myInDesign)
End Function