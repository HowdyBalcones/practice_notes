Rem MergeTableCells.vbs
Rem An InCopy VBScript
Rem
Rem Shows how to merge cells in a table.
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
	Set myStory = myDocument.Stories.Item(1)
	myString = "Table" & vbCr
	myStory.Contents = myString
	Set myTable = myStory.InsertionPoints.Item(-1).Tables.Add
	myTable.ColumnCount = 4
	myTable.BodyRowCount = 4
End Function
Function mySnippet(myInCopy)
	Set myDocument = myInCopy.Documents.Item(1)
	Set myStory = myDocument.Stories.Item(1)
	Set myTable = myStory.Tables.Item(1)
	Rem Merge all of the cells in the first column.
	myTable.Cells.Item(1).Merge myTable.Columns.Item(1).Cells.Item(-1)
	Rem Convert column 2 into 2 cells (rather than 4).
	myTable.Columns.Item(2).Cells.Item(-1).Merge myTable.Columns.Item(2).Cells.Item(-2)
	myTable.Columns.Item(2).Cells.Item(1).Merge myTable.Columns.Item(2).Cells.Item(2)
	Rem Merge the last two cells in row 1.
	myTable.Rows.Item(1).Cells.Item(-1).Merge myTable.Rows.Item(1).Cells.Item(-1)
	Rem Merge the last two cells in row 3.
	myTable.Rows.Item(3).Cells.Item(-2).Merge myTable.Rows.Item(3).Cells.Item(-1)
End Function
Function myTeardown(myInCopy)
End Function

