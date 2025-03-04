Rem SplitTableCells.vbs
Rem An InCopy VBScript
Rem
Rem Shows how to split cells, column, and rows in a table.
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
	Set myStory = myDocument.Stories.Item(1)
	myString = "Table" & vbCr
	myStory.contents = myString
	Set myCreateExampleDocument = myDocument
End Function
Function mySnippet(myInCopy)
	Set myDocument = myInCopy.Documents.Item(1)
	Set myStory = myDocument.Stories.Item(1)
	Set myTable = myStory.InsertionPoints.Item(-1).Tables.Add
	myTable.ColumnCount = 1
	myTable.BodyRowCount = 1
	myArray = myGetBounds(myDocument, myDocument.Pages.Item(1))
	myWidth = myArray(3) - myArray(1)
	myTable.Columns.Item(1).Width = myWidth
	myTable.Cells.Item(1).Split idHorizontalOrVertical.idHorizontal
	myTable.Columns.Item(1).Split idHorizontalOrVertical.idVertical
	myTable.Cells.Item(1).Split idHorizontalOrVertical.idVertical
	myTable.Rows.Item(-1).Split idHorizontalOrVertical.idHorizontal
	myTable.Cells.Item(-1).Split idHorizontalOrVertical.idVertical
	For myRowCounter = 1 To myTable.Rows.Count
		Set myRow = myTable.Rows.Item(myRowCounter)
		For myCellCounter = 1 To myRow.Cells.Count
			myString = "Row: " & myRowCounter & " Cell: " & myCellCounter
			myRow.Cells.Item(myCellCounter).contents = myString
		Next
	Next
End Function
Function myTeardown(myInCopy)
End Function
Function myGetBounds(myDocument, myPage)
	myPageWidth = myDocument.DocumentPreferences.PageWidth
	myPageHeight = myDocument.DocumentPreferences.PageHeight
	If myPage.Side = idPageSideOptions.idLeftHand Then
		myX2 = myPage.MarginPreferences.Left
		myX1 = myPage.MarginPreferences.Right
	Else
		myX1 = myPage.MarginPreferences.Left
		myX2 = myPage.MarginPreferences.Right
	End If
	myY1 = myPage.marginPreferences.Top
	myX2 = myPageWidth - myX2
	myY2 = myPageHeight - myPage.MarginPreferences.Bottom
	myGetBounds =  Array(myY1, myX1, myY2, myX2)
End Function