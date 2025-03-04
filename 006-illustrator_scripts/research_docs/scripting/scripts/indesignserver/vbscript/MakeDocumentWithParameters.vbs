Rem MakeDocumentWithParameters.vbs
Rem An InDesign Server VBScript
Rem Creates a new document.
Rem The parameter (DocumentPreset) specifies the document preset to use.
Rem The following line assumes that you have defined a document preset named
Rem "7x9Book" (the example script DocumentPreset.vbs will create a preset
Rem with this name).
Set myInDesignServer = CreateObject("InDesignServer.Application")
Set myDocument = myInDesignServer.Documents.Add(myInDesignServer.DocumentPresets.Item("7x9Book"))

Rem Save the file (fill in a valid file path on your system).
Set filesys = CreateObject("Scripting.FileSystemObject")
myFolderPath = "c:\ServerTestFiles"
If Not filesys.FolderExists(myFolderPath) Then
    filesys.CreateFolder(myFolderPath)
End If
Set myDocument = myDocument.Save(myFolderPath & "\" & "myTestDocument.indd")

Rem Close the document
myDocument.Close
