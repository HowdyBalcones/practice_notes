Rem DocumentAndBaselineGrids.vbs
Rem An InDesign VBScript
Rem
Rem Creates a document, then sets preferences for the
Rem document grid and baseline grid.
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
	Rem ![Setting grid preferences.]
	Rem Set the document measurement units to points.
	Set myDocument = myInDesign.Documents.Item(1)	
	myDocument.ViewPreferences.HorizontalMeasurementUnits = idMeasurementUnits.idPoints
	myDocument.ViewPreferences.VerticalMeasurementUnits = idMeasurementUnits.idPoints
	Rem Set up grid preferences.
	With myDocument.GridPreferences
		.BaselineStart = 56
		.BaselineDivision = 14
		.BaselineGridShown = True
		.HorizontalGridlineDivision = 14
		.HorizontalGridSubdivision = 5
		.VerticalGridlineDivision = 14
		.VerticalGridSubdivision = 5
		.DocumentGridShown = True
	End With
	Rem ![Setting grid preferences.]
End Function
Function myTeardown(myInDesign)
End Function