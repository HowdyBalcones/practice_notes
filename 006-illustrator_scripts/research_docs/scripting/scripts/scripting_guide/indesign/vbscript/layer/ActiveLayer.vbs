Rem ActiveLayer.vbs
Rem An InDesign VBScript
Rem 
Rem Shows how to get a reference to the active layer.
main
Function main()
	Set myInDesign = CreateObject("InDesign.Application.2024")
	mySetup myInDesign
	mySnippet myInDesign
	myTeardown myInDesign
End Function
Function mySetup(myInDesign)
	myInDesign.Documents.Add
End Function
Function mySnippet(myInDesign)
	Set myDocument = myInDesign.Documents.Item(1)
	Rem ![Add active layer.]
	Rem Given a document "myDocument"...
	Set myLayer = myDocument.ActiveLayer
	Rem ![Add active layer.]
End Function
Function myTeardown(myInDesign)
End Function