Rem GuideAndGridPreferences.vbs
Rem An InDesign Server VBScript
Rem Sets preferences for guides and grids.
Rem Assumes you have a document open.
Set myInDesignServer = CreateObject("InDesignServer.Application")
Set myDocument = myInDesignServer.Documents.Add
With myDocument.GuidePreferences
    .GuidesInBack = True
    .GuidesLocked = False
    .GuidesShown = True
    .GuidesSnapto = True
End With
With myDocument.GridPreferences
    .DocumentGridShown = False
    .DocumentGridSnapto = True
    Rem Objects "snap" to the baseline grid when
    Rem GuidePreferences.GuideSnapTo is set to true.
    .BaselineGridShown = True
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