Rem ImprovedHelloWorld.vbs
Set myInCopy = CreateObject("InCopy.Application.2024")
Rem Disable normal error handling (trying to get a non-
Rem existent font can cause errors).
On Error Resume Next
Rem Enter the name of a font on your system, if necessary.
Set myFont = myInCopy.Fonts.Item("Arial")
If Error.Number <> 0 Then
	Error.Clear
End If
Rem Resume normal error handling.
On Error Goto 0
Rem Get the active document and assign the result to the variable "myDocument"
Set myDocument = myInCopy.Documents.Item(1)
Set myStory = myDocument.Stories.Item(1)
Rem Change the font, size, and paragraph alignment.
If TypeName(myFont) <> "Nothing" Then
	myStory.AppliedFont = myFont
End If
myStory.PointSize = 48
myStory.Justification = idJustification.idCenterAlign
Rem Enter the note at the last insertion point of the story.
Set myInsertionPoint = myStory.InsertionPoints.Item(-1)
Set myNote = myInsertionPoint.Notes.Add
myNote.Texts.Item(1).Contents = "This is a Note."