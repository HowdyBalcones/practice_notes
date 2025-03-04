Rem DocumentPresetByExample.vbs
Rem An InDesign Server VBScript
Rem Creates a document preset based on the current document settings.
Rem Assumes you have a document open.
Set myInDesignServer = CreateObject("InDesignServer.Application")
If myInDesignServer.Documents.Count > 0 Then
    Set myDocument = myInDesignServer.Documents.Item(1)
    Rem If the document preset "myDocumentPreset" does not already exist, create it.
    Rem Disable normal error handling.
    Err.Clear
    On Error Resume Next
    Set myDocumentPreset = myInDesignServer.DocumentPresets.Item("myDocumentPreset")
    Rem If the document preset did not exist, the above line
    Rem generates an error. Handle the error.
    If (Err.Number <> 0) Then
        Set myDocumentPreset = myInDesignServer.DocumentPresets.Add
        myDocumentPreset.Name = "myDocumentPreset"
        Err.Clear
    End If
    Rem Restore normal error handling.
    On Error GoTo 0
    Rem Fill in the properties of the document preset with the corresponding
    Rem properties of the active document.
    With myDocumentPreset
        Rem Note that the following gets the page margins from the margin preferences
        Rem of the document to get the margin preferences from the active page,
        Rem replace "myDocument" with "myInDesignServer.activeWindow.activePage" in the
        Rem following six lines (assuming the active window is a layout window).
        .Left = myDocument.MarginPreferences.Left
        .Right = myDocument.MarginPreferences.Right
        .Top = myDocument.MarginPreferences.Top
        .Bottom = myDocument.MarginPreferences.Bottom
        .ColumnCount = myDocument.MarginPreferences.ColumnCount
        .ColumnGutter = myDocument.MarginPreferences.ColumnGutter
        .DocumentBleedBottomOffset = myDocument.DocumentPreferences.DocumentBleedBottomOffset
        .DocumentBleedTopOffset = myDocument.DocumentPreferences.DocumentBleedTopOffset
        .DocumentBleedInsideOrLeftOffset = myDocument.DocumentPreferences.DocumentBleedInsideOrLeftOffset
        .DocumentBleedOutsideOrRightOffset = myDocument.DocumentPreferences.DocumentBleedOutsideOrRightOffset
        .FacingPages = myDocument.DocumentPreferences.FacingPages
        .PageHeight = myDocument.DocumentPreferences.PageHeight
        .PageWidth = myDocument.DocumentPreferences.PageWidth
        .PageOrientation = myDocument.DocumentPreferences.PageOrientation
        .PagesPerDocument = myDocument.DocumentPreferences.PagesPerDocument
        .SlugBottomOffset = myDocument.DocumentPreferences.SlugBottomOffset
        .SlugTopOffset = myDocument.DocumentPreferences.SlugTopOffset
        .SlugInsideOrLeftOffset = myDocument.DocumentPreferences.SlugInsideOrLeftOffset
        .SlugRightOrOutsideOffset = myDocument.DocumentPreferences.SlugRightOrOutsideOffset
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

Else
    returnValue = "No documents are open."
End If
