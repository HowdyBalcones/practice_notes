Rem BleedSlugGuideColors.vbs
Rem An InDesign Server VBScript
Rem Set the colors used to display the bleed and slug guides.
Set myInDesignServer = CreateObject("InDesignServer.Application")
Set myDocument = myInDesignServer.Documents.Add
Rem Set the bleed and slug properties.
With myDocument.DocumentPreferences
    Rem Bleed
    .DocumentBleedTopOffset = "3p"
    .DocumentBleedUniformSize = True
    Rem Slug (large slug area at bottom provides room for
    Rem comments, tracking information, etc.)
    .SlugBottomOffset = "18p"
    .SlugTopOffset = "3p"
    .SlugInsideOrLeftOffset = "3p"
    .SlugRightOrOutsideOffset = "3p"
End With
With myDocument.PasteboardPreferences
    Rem Any of InDesign's guides can use the UIColors constants...
    .BleedGuideColor = idUIColors.idCuteTeal
    .SlugGuideColor = idUIColors.idCharcoal
    Rem ...or you can specify an array of RGB values (with values from 0 to 255)
    Rem .BleedGuideColor = Array(0, 198, 192)
    Rem .SlugGuideColor = Array(192, 192, 192)
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
