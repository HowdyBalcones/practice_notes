Rem SimpleDialog.vbs
Rem An InCopy VBScript
Rem
Rem Creates a simple InCopy dialog box.
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
	Set myDialog = myInCopy.Dialogs.Add
	myDialog.name = "Simple Dialog"
	Rem Add a dialog column.
	With myDialog.DialogColumns.Add
	    With .StaticTexts.Add
	        .StaticLabel = "This is a very simple dialog box."
	    End With
	End With
	Rem Show the dialog box.
	myResult = myDialog.Show
	Rem If the user clicked OK, display one message;
	Rem if they clicked Cancel, display a different message.
	If myResult = True Then
	    MsgBox "You clicked the OK button."
	Else
	    MsgBox "You clicked the Cancel button."
	End If
	Rem Remove the dialog box from memory.
	myDialog.Destroy
End Function
Function myTeardown(myInCopy)
End Function