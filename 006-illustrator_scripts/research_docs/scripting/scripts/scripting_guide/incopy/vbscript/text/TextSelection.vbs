Rem TextSelection.vbs
Rem An InCopy VBScript
Rem
Rem Shows how to determine whether the current selection is a text selection.
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
	Rem <fragment>
	Function mySnippet(myInCopy)
	If myInCopy.Documents.Count <> 0 Then
		Rem If the selection contains more than one item, the selection
		Rem is not text selected with the Type tool.
		If myInCopy.Selection.Count = 1 Then
			Select Case TypeName(myInCopy.Selection.Item(1))
				Case "InsertionPoint", "Character", "Word", "TextStyleRange", "Line", "Paragraph", "TextColumn", "Text"
					MsgBox "The selection is a text object."
					Rem A real script would now act on the text object
					Rem or pass it on to a function.
				Case Else
					MsgBox "The selected object is not a text object. Select some text and try again."
			End Select
		Else
			MsgBox "Please select some text and try again."
		End If
	Else
		MsgBox "No documents are open. Please open a document, select some text, and try again."
	End If
	Rem </fragment>
End Function
Function myTeardown(myInCopy)
End Function