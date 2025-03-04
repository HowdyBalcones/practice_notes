Rem HelloWorldDialog.vbs
Rem An InCopy VBScript
Rem
Rem Adds a simple dialog box to the HelloWorld script.
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
	myDialog.CanCancel = True
	myDialog.Name = " Simple User Interface Example Script"
	Set myDialogColumn = myDialog.DialogColumns.Add
	Set myTextEditField = myDialogColumn.TextEditboxes.Add
	myTextEditField.EditContents = "Hello World!"
	myTextEditField.MinWidth = 180
	Rem Create a number (real) entry field.
	Set myPointSizeField = myDialogColumn.RealEditboxes.Add
	myPointSizeField.EditValue = 72
	myDialog.Show
	Rem Get the values from the dialog box controls.
	myString = myTextEditField.EditContents
	myPointSize = myPointSizeField.EditValue
	Rem Remove the dialog box from memory.
	myDialog.Destroy
	Rem Create a new document.
	Set myDocument = myInCopy.Documents.Add
	Set myStory = myDocument.Stories.Item(1)
	Rem Enter the text from the dialog box in the text frame.
	myStory.Contents = myString
	Rem Set the size of the text to the size you entered in the dialog box.
	myStory.Texts.Item(1).PointSize = myPointSize
End Function
Function myTeardown(myInCopy)
End Function