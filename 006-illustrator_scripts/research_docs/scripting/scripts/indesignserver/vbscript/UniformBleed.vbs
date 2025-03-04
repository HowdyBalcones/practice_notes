Rem UniformBleed.vbs
Rem An InDesign Server VBScript
Rem Create a new document.
Set myInDesignServer = CreateObject("InDesignServer.Application")
Set myDocument = myInDesignServer.Documents.Add
Rem The bleed properties belong to the documentPreferences object.
With myDocument.DocumentPreferences
    Rem Bleed
    .DocumentBleedTopOffset = "3p"
    .DocumentBleedUniformSize = True
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
