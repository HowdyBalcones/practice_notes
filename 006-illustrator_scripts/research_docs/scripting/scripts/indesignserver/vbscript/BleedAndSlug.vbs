Rem BleedAndSlug.vbs
Rem An InDesign Server VBScript
Rem Create a new document.
Set myInDesignServer = CreateObject("InDesignServer.Application")
Set myDocument = myInDesignServer.Documents.Add
Rem The bleed and slug properties belong to the documentPreferences object.
With myDocument.DocumentPreferences
    Rem Bleed
    .DocumentBleedBottomOffset = "3p"
    .DocumentBleedTopOffset = "3p"
    .DocumentBleedInsideOrLeftOffset = "3p"
    .DocumentBleedOutsideOrRightOffset = "3p"
    Rem Slug
    .SlugBottomOffset = "18p"
    .SlugTopOffset = "3p"
    .SlugInsideOrLeftOffset = "3p"
    .SlugRightOrOutsideOffset = "3p"
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