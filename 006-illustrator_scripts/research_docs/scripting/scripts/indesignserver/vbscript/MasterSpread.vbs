Rem MasterSpread.vbs
Rem An InDesign Server VBScript
Rem Creates a document, then demonstrates setting master spread properties.
Set myInDesignServer = CreateObject("InDesignServer.Application")
Rem Set up the first master spread in a new document.
Set myDocument = myInDesignServer.Documents.Add
Rem Set up the document.
With myDocument.DocumentPreferences
    .PageHeight = "11i"
    .PageWidth = "8.5i"
    .FacingPages = True
    .PageOrientation = idPageOrientation.idPortrait
End With
Rem Set the document's ruler origin to page origin. This is very important
Rem --if you don't do this, getting objects to the correct position on the
Rem page is much more difficult.
myDocument.ViewPreferences.RulerOrigin = idRulerOrigin.idPageOrigin
With myDocument.MasterSpreads.Item(1)
    Rem Set up the left page (verso).
    With .Pages.Item(1)
        With .MarginPreferences
            .ColumnCount = 3
            .ColumnGutter = "1p"
            .Bottom = "6p"
            Rem "left" means inside "right" means outside.
            .Left = "6p"
            .Right = "4p"
            .Top = "4p"
        End With
        Rem Add a simple footer with a section number and page number.
        With .TextFrames.Add
            .GeometricBounds = Array("61p", "4p", "62p", "45p")
            .InsertionPoints.Item(1).Contents = idSpecialCharacters.idSectionMarker
            .InsertionPoints.Item(1).Contents = idSpecialCharacters.idEmSpace
            .InsertionPoints.Item(1).Contents = idSpecialCharacters.idAutoPageNumber
            .Paragraphs.Item(1).Justification = idJustification.idLeftAlign
        End With
    End With
    Rem Set up the right page (recto).
    With .Pages.Item(2)
        With .MarginPreferences
            .ColumnCount = 3
            .ColumnGutter = "1p"
            .Bottom = "6p"
            Rem "left" means inside "right" means outside.
            .Left = "6p"
            .Right = "4p"
            .Top = "4p"
        End With
        Rem Add a simple footer with a section number and page number.
        With .TextFrames.Add
            .GeometricBounds = Array("61p", "6p", "62p", "47p")
            .InsertionPoints.Item(1).Contents = idSpecialCharacters.idAutoPageNumber
            .InsertionPoints.Item(1).Contents = idSpecialCharacters.idEmSpace
            .InsertionPoints.Item(1).Contents = idSpecialCharacters.idSectionMarker
            .Paragraphs.Item(1).Justification = idJustification.idRightAlign
        End With
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