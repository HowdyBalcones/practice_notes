Rem DocumentPreferences.vbs
Rem An InDesign Server VBScript
Rem Use the documentPreferences object to change the
Rem dimensions and orientation of the document.
Set myInDesignServer = CreateObject("InDesignServer.Application")
Set myDocument = myInDesignServer.Documents.Add
With myDocument.DocumentPreferences
    .PageHeight = "800pt"
    .PageWidth = "600pt"
    .PageOrientation = idPageOrientation.idLandscape
    .PagesPerDocument = 16
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