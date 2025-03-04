Rem MakeDocument.vbs
Rem An InDesign Server VBScript
Rem Creates a new document.
Set myInDesignServer = CreateObject("InDesignServer.Application")
Set myDocument = myInDesignServer.Documents.Add

Rem Save the file (fill in a valid file path on your system).
Set filesys = CreateObject("Scripting.FileSystemObject")
myFolderPath = "c:\ServerTestFiles"
If Not filesys.FolderExists(myFolderPath) Then
    filesys.CreateFolder(myFolderPath)
End If
Set myDocument = myDocument.Save(myFolderPath & "\" & "myTestDocument.indd")

Rem Close the document
myDocument.Close
