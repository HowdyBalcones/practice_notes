Rem BleedAndSlug.vbs
Rem An InDesign VBScript
Rem
Rem Shows how to define the bleed and slug areas of a document.
main
Function main()
	Set myInDesign = CreateObject("InDesign.Application.2024")
	mySetup myInDesign
	mySnippet myInDesign
	myTeardown myInDesign
End Function
Function mySetup(myInDesign)
   Set myInDesign = CreateObject("InDesign.Application.2024")
   Set myDocument = myInDesign.Documents.Add
End Function
Function mySnippet(myInDesign)
	Rem ![Bleed and slug.]
	Set myDocument = myInDesign.Documents.Item(1)
	Rem The bleed and slug properties belong to the documentPreferences object.
	With myDocument.DocumentPreferences
	Rem Bleed
		.DocumentBleedBottomOffset = "3p"
		.DocumentBleedTopOffset = "3p"
		.DocumentBleedInsideOrLeftOffset = "3p"
		.DocumentBleedOutsideOrRightOffset = "3p"
		Rem Slug
		.SlugBottomOffset = "18p"
		.SlugTopOffset = "3p"
		.SlugInsideOrLeftOffset = "3p"
		.SlugRightOrOutsideOffset = "3p"
	End With
	Rem ![Bleed and slug.]
End Function
Function myTeardown(myInDesign)
End Function