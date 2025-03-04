Rem RemovePathPoint.vbs
Rem An InDesign VBScript
Rem 
Rem Shows how to remove a point from a path.
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
	Set myPage = myDocument.Pages.Item(1)
	Set myGraphicLine = myPage.GraphicLines.Add
	myGraphicLine.Paths.Item(1).PathPoints.Item(1).Anchor = Array(72, 72)
	myGraphicLine.Paths.Item(1).PathPoints.Item(2).Anchor = Array(72, 144)
	Set myPathPoint = myGraphicLine.Paths.Item(1).PathPoints.Add
	myPathPoint.Anchor = Array(144, 144)
End Function
Function mySnippet(myInDesign)
	Set myDocument = myInDesign.Documents.Item(1)
	Set myPage = myDocument.Pages.Item(1)
	Set myGraphicLine = myPage.PageItems.Item(1)
	Rem <fragment>
	Rem Given a line "myGraphicLine", remove the 
	Rem last path point in the first path.
	myGraphicLine.Paths.Item(1).PathPoints.Item(-1).Delete
	Rem </fragment>
End Function
Function myTeardown(myInDesign)
End Function