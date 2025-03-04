Rem CustomLabel.vbs
Rem An InDesign VBScript
Rem
Rem Shows how to add and extract custom labels
Rem from page items.
main
Function main()
	Set myInDesign = CreateObject("InDesign.Application.2024")
	mySetup myInDesign
	mySnippet myInDesign
	myTeardown myInDesign
End Function
Rem ![Working with Custom Label.]
Function mySetup(myInDesign)
	Set myDocument = myInDesign.Documents.Add
	Set myPage = myDocument.Pages.Item(1)
	myDocument.ViewPreferences.HorizontalMeasurementUnits = idMeasurementUnits.idPoints
	myDocument.ViewPreferences.VerticalMeasurementUnits = idMeasurementUnits.idPoints
	Set myRectangle = myPage.Rectangles.Add
	myRectangle.GeometricBounds = Array(72, 72, 144, 144)
End Function
Function mySnippet(myInDesign)
	Set myDocument = myInDesign.Documents.Item(1)
	Set myPage = myDocument.Pages.Item(1)
	Set myRectangle = myPage.Rectangles.Item(1)
	Rem Insert a custom label using insertLabel. The first parameter is the
	Rem name of the label, the second is the text to add to the label.
	myRectangle.InsertLabel "CustomLabel", "This is some text stored in a custom label."
	Rem Extract the text from the label and display it in an message box.
	myString = myRectangle.ExtractLabel("CustomLabel")
	MsgBox ("Custom label contained: " + myString)
End Function
Rem ![Working with Custom Label.]
Function myTeardown(myInDesign)
End Function