Rem TableSelection.vbs
Rem An InCopy VBScript
Rem
Rem Shows how to determine if the selection is in a table.
Rem
main
Function main()
	Set myInCopy = CreateObject("InCopy.Application.2024")
	mySetup myInCopy
	mySnippet myInCopy
	myTeardown myInCopy
End Function
Function mySetup(myInCopy)
End Function
Function mySnippet(myInCopy)
If myInCopy.Documents.Count <> 0 Then
	If myInCopy.Selection.Count <> 0 Then
		Select Case TypeName(myInCopy.Selection.Item(1))
				Rem When a row, a column, or a range of cells is selected, the type returned is "Cell"
				Case "Cell"
					MsgBox ("A cell is selected.")
				Case "Table"
					MsgBox ("A table is selected.")
				Case "InsertionPoint", "Character", "Word", "TextStyleRange", "Line", "Paragraph", "TextColumn", "Text"
					If TypeName(myInCopy.Selection.Item(1).Parent) = "Cell" Then
						MsgBox ("The selection is inside a table cell.")
					Else
						MsgBox ("The selection is not inside a table.")            
					End If
				Case Else
				MsgBox ("The selection is not inside a table.")
		End Select
	End If
End If
End Function
Function myTeardown(myInCopy)
End Function