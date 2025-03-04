Rem SpreadAndPageGuides.vbs
Rem An InDesign Server VBScript
Rem Demonstrates the difference between spread guides and page guides.
Set myInDesignServer = CreateObject("InDesignServer.Application")
Set myDocument = myInDesignServer.Documents.Add
myDocument.DocumentPreferences.FacingPages = True
myDocument.DocumentPreferences.PagesPerDocument = 3
With myDocument.Spreads.Item(2)
    Rem Note the difference between these two guides on pages 2 and 3.
    With .Guides.Add
        .Orientation = idHorizontalOrVertical.idHorizontal
        .Location = "6p"
        .FitToPage = True
    End With
    With .Guides.Add
        .Orientation = idHorizontalOrVertical.idHorizontal
        .Location = "9p"
        .FitToPage = False
    End With
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
