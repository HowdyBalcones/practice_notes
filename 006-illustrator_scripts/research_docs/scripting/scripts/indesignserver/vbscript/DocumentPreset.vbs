Rem DocumentPreset.vbs
Rem An InDesign Server VBScript
Rem Creates a new document preset.
Set myInDesignServer = CreateObject("InDesignServer.Application")
Rem If the document preset "7x9Book" does not already exist, create it.
Err.Clear
On Error Resume Next
Set myDocumentPreset = myInDesignServer.DocumentPresets.Item("7x9Book")
If Err.Number <> 0 Then
    Set myDocumentPreset = myInDesignServer.DocumentPresets.Add
    myDocumentPreset.Name = "7x9Book"
    Err.Clear
End If
On Error GoTo 0
Rem Fill in the properties of the document preset.
With myDocumentPreset
    .PageHeight = "9i"
    .PageWidth = "7i"
    .Left = "4p"
    .Right = "6p"
    .Top = "4p"
    .Bottom = "9p"
    .ColumnCount = 1
    .DocumentBleedBottomOffset = "3p"
    .DocumentBleedTopOffset = "3p"
    .DocumentBleedInsideOrLeftOffset = "3p"
    .DocumentBleedOutsideOrRightOffset = "3p"
    .FacingPages = True
    .PageOrientation = idPageOrientation.idPortrait
    .PagesPerDocument = 1
    .SlugBottomOffset = "18p"
    .SlugTopOffset = "3p"
    .SlugInsideOrLeftOffset = "3p"
    .SlugRightOrOutsideOffset = "3p"
End With
