Rem TextColors.vbs
Rem An InCopy VBScript
Rem
Rem Shows how to apply colors to the fill and stroke of text.
Rem
main
Function main()
	Set myInCopy = CreateObject("InCopy.Application.2024")
	mySetup myInCopy
	mySnippet myInCopy
	myTeardown myInCopy
End Function
Function mySetup(myInCopy)
	Rem Create an example document.
	Set myDocument = myInCopy.Documents.Add
	Rem Add two colors.
	myAddColor myDocument, "DGC1_446a", idColorModel.idProcess, Array(0, 100, 0, 50)
	myAddColor myDocument, "DGC1_446b", idColorModel.idProcess, Array(100, 0, 50, 0)
	Rem Given two colors "myColorA" and "myColorB"...
End Function
Function mySnippet(myInCopy)
	Set myDocument = myInCopy.Documents.Item(1)
	Set myStory = myDocument.Stories.Item(1)
	myStory.contents = "Text" & vbCr & "Color"
	Set myText = myStory.Paragraphs.Item(1)
	myText.PointSize = 72
	myText.Justification = idJustification.idCenterAlign
	Set myText = myStory.Paragraphs.Item(2)
	myText.StrokeWeight = 3
	myText.PointSize = 144
	myText.Justification = idJustification.idCenterAlign
	Rem Apply a color to the fill of the text.
	Set myText = myStory.Paragraphs.Item(1)
	myText.FillColor = myDocument.Colors.Item("DGC1_446a")
	Rem Use the itemByRange method to apply the color to the stroke of the text.
	myText.StrokeColor = myDocument.Swatches.Item("DGC1_446b")
	Set myText = myStory.Paragraphs.Item(2)
	myText.FillColor = myDocument.Swatches.Item("DGC1_446b")
	myText.StrokeColor = myDocument.Swatches.Item("DGC1_446a")
myText.StrokeWeight = 3
End Function
Function myTeardown(myInCopy)
End Function
Function myAddColor(myDocument, myColorName, myColorModel, myColorValue)
	On Error Resume Next
	Set myColor = myDocument.Colors.Item(myColorName)
	If Err.Number <> 0 Then
		Set myColor = myDocument.Colors.Add
		myColor.Name = myColorName
		Err.Clear
	End If
	On Error GoTo 0
	myColor.Model = myColorModel
	myColor.ColorValue = myColorValue
	Set myAddColor = myColor
End Function
