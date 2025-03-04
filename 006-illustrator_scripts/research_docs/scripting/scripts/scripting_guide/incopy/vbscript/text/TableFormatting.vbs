Rem TableFormatting.vbs
Rem An InCopy VBScript
Rem
Rem Shows how to format table cells.
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
	Set myStory = myDocument.Stories.Item(1)
	myString = "Head 1" & vbTab & "Head 2" & vbTab & "Head 3" & vbCr & "1a" & vbTab & "1b" & vbTab & "1c" & vbCr & "2a" & vbTab & "2b" & vbTab & "2c" & vbCr & "3a" & vbTab & "3b" & vbTab & "3c"
	myStory.Contents = myString
	myStory.Texts.Item(1).ConvertToTable
	Set myCreateExampleDocument = myDocument
End Function
Function mySnippet(myInCopy)
	Set myDocument = myInCopy.Documents.Item(1)
	Set myStory = myDocument.Stories.Item(1)
	Set myTable = myStory.Tables.Item(1)
	Rem Convert the first row to a header row.
	myTable.Rows.Item(1).RowType = idRowTypes.idHeaderRow
	Rem Use a reference to a swatch, rather than to a color.
	myTable.Rows.Item(1).FillColor = myDocument.Swatches.Item("DGC1_446b")
	myTable.Rows.Item(1).FillTint = 40
	myTable.Rows.Item(2).FillColor = myDocument.Swatches.Item("DGC1_446a")
	myTable.Rows.Item(2).FillTint = 40
	myTable.Rows.Item(3).FillColor = myDocument.Swatches.Item("DGC1_446a")
	myTable.Rows.Item(3).FillTint = 20
	myTable.Rows.Item(4).FillColor = myDocument.Swatches.Item("DGC1_446a")
	myTable.Rows.Item(4).FillTint = 40
	Rem Iterate through the cells to apply the cell stroke formatting.
	For myCounter = 1 To myTable.Cells.Count
		myTable.Cells.Item(myCounter).TopEdgeStrokeColor = myDocument.Swatches.Item("DGC1_446b")
		myTable.Cells.Item(myCounter).TopEdgeStrokeWeight = 1
		myTable.Cells.Item(myCounter).BottomEdgeStrokeColor = myDocument.Swatches.Item("DGC1_446b")
		myTable.Cells.Item(myCounter).BottomEdgeStrokeWeight = 1
		Rem When you set a cell stroke to a swatch, make certain that you also set the stroke weight.
		myTable.Cells.Item(myCounter).LeftEdgeStrokeColor = myDocument.Swatches.Item("None")
		myTable.Cells.Item(myCounter).LeftEdgeStrokeWeight = 0
		myTable.Cells.Item(myCounter).RightEdgeStrokeColor = myDocument.Swatches.Item("None")
		myTable.Cells.Item(myCounter).RightEdgeStrokeWeight = 0
	Next
End Function
Function myTeardown(myInCopy)
End Function
Function myAddColor(myDocument, myColorName, myColorModel, myColorValue)
	On Error Resume Next
	Set myColor = myDocument.colors.Item(myColorName)
	If Err.Number <> 0 Then
		Set myColor = myDocument.colors.Add
		Err.Clear
	End If
	On Error GoTo 0
	myColor.Name = myColorName
	myColor.model = myColorModel
	myColor.colorValue = myColorValue
End Function