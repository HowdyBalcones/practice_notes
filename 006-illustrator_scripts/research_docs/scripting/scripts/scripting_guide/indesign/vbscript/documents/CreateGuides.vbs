Rem CreateGuides.vbs
Rem An InDesign VBScript
Rem
Rem Add a series of guides using the CreateGuides method.
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
	Rem Add a series of guides using the CreateGuides method.
	Rem ![Create guides.]
	Set myDocument = myInDesign.Documents.Item(1)
	Set myLayer = myDocument.Layers.Item(1)
	With myDocument.Spreads.Item(1)
		Rem Parameters (all optional): row count, column count, row gutter,
		Rem column gutter,guide color, fit margins, remove existing, layer.
		Rem Note that the createGuides method does not take an RGB array
		Rem for the guide color parameter.
		.CreateGuides 4, 4, "1p", "1p", idUIColors.idGray, True, True, myLayer
	End With
	Rem ![Create guides.]
End Function
Function myTeardown(myInDesign)
End Function