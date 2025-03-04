Rem MarginsAndColumns.vbs
Rem An InDesign Server VBScript
Rem Sets up the margins and columns for the first page of an example document.
Set myInDesignServer = CreateObject("InDesignServer.Application")
Set myDocument = myInDesignServer.Documents.Add
With myDocument.Pages.Item(1).MarginPreferences
    .ColumnCount = 3
    Rem columnGutter can be a number or a measurement string.
    .ColumnGutter = "1p"
    .Top = "4p"
    .Bottom = "6p"
    Rem When document.documentPreferences.facingPages = true,
    Rem "left" means inside "right" means outside.
    .Left = "6p"
    .Right = "4p"
End With

Rem Save the file (fill in a valid file path on your system).
Set filesys = CreateObject("Scripting.FileSystemObject")
myFolderPath = "c:\ServerTestFiles"
If Not filesys.FolderExists(myFolderPath) Then
    filesys.CreateFolder(myFolderPath)
End If
Set myDocument = myDocument.Save(myFolderPath & "\" & "myTestDocument.indd")

Rem Close the document
myDocument.Close
