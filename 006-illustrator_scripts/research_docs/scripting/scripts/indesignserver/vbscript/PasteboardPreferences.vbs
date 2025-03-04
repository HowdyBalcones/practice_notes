Rem PasteboardPreferences.vbs
Rem An InDesign Server VBScript
Rem Create a new document and change the size of the pasteboard.
Set myInDesignServer = CreateObject("InDesignServer.Application")
Set myDocument = myInDesignServer.Documents.Add
With myDocument.PasteboardPreferences
    Rem You can set the preview background color (which you'll only see
    Rem in Preview mode) to any of the predefined UIColor constants...
    .PreviewBackgroundColor = idUIColors.idGrassGreen
    Rem ...or you can specify an array of RGB values (with values from 0 to 255)
    Rem .PreviewBackgroundColor = Array(192, 192, 192)
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
