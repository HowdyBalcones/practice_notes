Rem AlternatingRows.vbs
Rem An InCopy VBScript
Rem
Rem Shows how to format table rows using alternating rows.
main
Function main()
	Set myInCopy = CreateObject("InCopy.Application.2024")
	mySetup myInCopy
	mySnippet myInCopy
	myTeardown myInCopy
End Function
Function mySetup(myInCopy)
	Rem Create an example document.
	Set myDocument = myInCopy.documents.Add
	Rem Add colors.
	myAddColor myDocument, "DGC1_446a", idColorModel.idProcess, Array(0, 100, 0, 50)
	myAddColor myDocument, "DGC1_446b", idColorModel.idProcess, Array(100, 0, 50, 0)
	Set myStory = myDocument.Stories.Item(1)
	myString = "Head 1" & vbTab & "Head 2" & vbTab & "Head 3" & vbCr & "1a" & vbTab & "1b" & vbTab & "1c" & vbCr & "2a" & vbTab & "2b" & vbTab & "2c" & vbCr & "3a" & vbTab & "3b" & vbTab & "3c\r4a" & vbTab & "4b" & vbTab & "4c" & vbCr & "5a" & vbTab & "5b" & vbTab & "5c"
	myStory.Contents = myString
	myStory.texts.Item(1).convertToTable
End Function
Function mySnippet(myInCopy)
	Set myDocument = myInCopy.Documents.Item(1)
	Rem <fragment>
	Set myTable = myDocument.stories.Item(1).tables.Item(1)
	Rem Convert the first row to a header row.
	myTable.rows.Item(1).rowType = idRowTypes.idHeaderRow
	Rem Applly alternating fills to the table.
	myTable.alternatingFills = idAlternatingFillsTypes.idAlternatingRows
	myTable.startRowFillColor = myDocument.swatches.Item("DGC1_446a")
	myTable.startRowFillTint = 60
	myTable.endRowFillColor = myDocument.swatches.Item("DGC1_446b")
	myTable.endRowFillTint = 50
	Rem </fragment>
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