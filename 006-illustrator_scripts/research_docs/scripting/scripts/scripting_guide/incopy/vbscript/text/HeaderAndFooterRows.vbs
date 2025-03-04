Rem HeaderAndFooterRows.vbs
Rem An InCopy VBScript
Rem
Rem Shows how to add header and footer rows to a table.
Rem
main
Function main()
	Set myInCopy = CreateObject("InCopy.Application.2024")
	mySetup myInCopy
	mySnippet myInCopy
	myTeardown myInCopy
End Function
Function mySetup(myInCopy)
	Set myDocument = myInCopy.Documents.Add
	Rem Create a text frame on page 1.
	Set myStory = myDocument.Stories.Item(1)
	myString = "Head 1" & vbTab & "Head 2" & vbTab & "Head 3" & vbCr & "1a" & vbTab & "1b" & vbTab & "1c" & vbCr & "2a" & vbTab & "2b" & vbTab & "2c" & vbCr & "3a" & vbTab & "3b" & vbTab & "3c" & vbCr & "Foot 1" & vbTab & "Foot 2" & vbTab & "Foot 3"
	myStory.Contents = myString
	myStory.Texts.Item(1).ConvertToTable
End Function
Function mySnippet(myInCopy)
	Set myDocument = myInCopy.Documents.Item(1)
	Set myTable = myDocument.Stories.Item(1).Tables.Item(1)
	Rem Convert the first row to a header row.
	myTable.Rows.Item(1).RowType = idRowTypes.idHeaderRow
	Rem Convert the last row to a footer row.
	myTable.Rows.Item(-1).RowType = idRowTypes.idFooterRow
End Function
Function myTeardown(myInCopy)
End Function