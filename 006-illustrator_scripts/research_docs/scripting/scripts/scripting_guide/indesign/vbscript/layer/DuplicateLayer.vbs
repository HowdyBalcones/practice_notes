Rem DuplicateLayer.vbs
Rem An InDesign VBScript
Rem 
Rem Shows how to duplicate a layer.
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
	Rem ![Duplicate layer.]
	Rem Given a document "myDocument"...
	Set myLayer = myDocument.Layers.Item(1)
	Set myLayer1 = myLayer.Duplicate()
	Rem ![Duplicate layer.]
End Function
Function myTeardown(myInDesign)
End Function