Rem Guides.vbs
Rem An InDesign Server VBScript
Rem Create a new document, add guides, and set guide properties.
Set myInDesignServer = CreateObject("InDesignServer.Application")
Set myDocument = myInDesignServer.Documents.Add
myPageWidth = myDocument.DocumentPreferences.PageWidth
myPageHeight = myDocument.DocumentPreferences.PageHeight
With myDocument.Pages.Item(1)
    Set myMarginPreferences = .MarginPreferences
    Rem Place guides at the margins of the page.
    With .Guides.Add
        .Orientation = idHorizontalOrVertical.idVertical
        .Location = myMarginPreferences.Left
    End With
    With .Guides.Add
        .Orientation = idHorizontalOrVertical.idVertical
        .Location = (myPageWidth - myMarginPreferences.Right)
    End With
    With .Guides.Add
        .Orientation = idHorizontalOrVertical.idHorizontal
        .Location = myMarginPreferences.Top
    End With
    With .Guides.Add
        .Orientation = idHorizontalOrVertical.idHorizontal
        .Location = (myPageHeight - myMarginPreferences.Bottom)
    End With
    Rem Place a guide at the vertical center of the page.
    With .Guides.Add
        .Orientation = idHorizontalOrVertical.idVertical
        .Location = (myPageWidth / 2)
    End With
    Rem Place a guide at the horizontal center of the page.
    With .Guides.Add
        .Orientation = idHorizontalOrVertical.idHorizontal
        .Location = (myPageHeight / 2)
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