Rem ReleaseCompoundPath.vbs
Rem An InDesign VBScript
Rem 
Rem Shows how to release a compound path.
main
Function main()
	Set myInDesign = CreateObject("InDesign.Application.2024")
	mySetup myInDesign
	mySnippet myInDesign
	myTeardown myInDesign
End Function
Function mySetup(myInDesign)
	Set myDocument = myInDesign.Documents.Add
	myDocument.ViewPreferences.HorizontalMeasurementUnits = idMeasurementUnits.idPoints
	myDocument.ViewPreferences.VerticalMeasurementUnits = idMeasurementUnits.idPoints
	myDocument.ViewPreferences.RulerOrigin = idRulerOrigin.idPageOrigin
	Set myPage = myDocument.Pages.Item(1)
	Set myRectangle = myPage.Rectangles.Add
	myRectangle.GeometricBounds = Array(72, 72, 144, 144)
	Set myOval = myPage.Ovals.Add
	myOval.GeometricBounds = Array(108, 108, 180, 180)
	myRectangle.MakeCompoundPath myOval
End Function
Function mySnippet(myInDesign)
	Set myCompoundPath = myInDesign.Documents.Item(1).Pages.Item(1).Rectangles.Item(1)	
	Rem ![Release compound path.]
	Rem Given a path "myCompoundPath" (all compound paths are type Rectangle)...
	Set mPageItems = myCompoundPath.ReleaseCompoundPath
	Rem ![Release compound path.]
End Function
Function myTeardown(myInDesign)
End Function