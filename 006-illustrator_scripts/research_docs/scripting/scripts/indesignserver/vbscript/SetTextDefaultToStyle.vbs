Rem SetTextDefaultToStyle.vbs
Rem An InDesign Server VBScript
Set myInDesignServer = CreateObject("InDesignServer.Application")
Set myDocument = myInDesignServer.Documents.Add
Rem If the paragraph style "BodyText" does not already exist, create it.
On Error Resume Next
    Set myParagraphStyle = myDocument.ParagraphStyles.Item("BodyText")
    If Err.Number <> 0 Then
        Set myParagraphStyle = myDocument.ParagraphStyles.Add
        myParagraphStyle.Name = "BodyText"
        Err.Clear
    End If
On Error GoTo 0
myDocument.TextDefaults.AppliedParagraphStyle = myParagraphStyle

Rem Save the file (fill in a valid file path on your system).
Set filesys = CreateObject("Scripting.FileSystemObject")
myFolderPath = "c:\ServerTestFiles"
If Not filesys.FolderExists(myFolderPath) Then
    filesys.CreateFolder(myFolderPath)
End If
Set myDocument = myDocument.Save(myFolderPath & "\" & "myTestDocument.indd")

Rem Close the document
myDocument.Close
