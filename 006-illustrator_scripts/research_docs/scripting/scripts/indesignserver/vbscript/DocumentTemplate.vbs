Rem DocumentTemplate.vbs
Rem An InDesign Server VBScript
Rem Creates a document template, including master pages, layers,
Rem a color, paragraph and character styles, guides, and XMP information.
Set myInDesignServer = CreateObject("InDesignServer.Application")
Rem Make a new document.
Set myDocument = myInDesignServer.Documents.Add
Rem Set the document default measurement units to points.
myDocument.ViewPreferences.HorizontalMeasurementUnits = idMeasurementUnits.idPoints
myDocument.ViewPreferences.VerticalMeasurementUnits = idMeasurementUnits.idPoints
With myDocument.MarginPreferences
    Rem Document baseline grid will be based on 14 points, and
    Rem all margins are set in increments of 14 points.
    .Top = 14 * 4
    .Left = 14 * 4
    .Bottom = 74
    .Right = 14 * 5
End With
myDocument.DocumentPreferences.PageWidth = "7i"
myDocument.DocumentPreferences.PageHeight = "9i"
myDocument.DocumentPreferences.PageOrientation = idPageOrientation.idPortrait
Rem Set up the bleed and slug areas.
With myDocument.DocumentPreferences
    Rem Bleed
    .DocumentBleedTopOffset = "3p"
    .DocumentBleedUniformSize = True
    Rem Slug
    .SlugBottomOffset = "18p"
    .SlugTopOffset = "3p"
    .SlugInsideOrLeftOffset = "3p"
    .SlugRightOrOutsideOffset = "3p"
End With
Rem Create a color.
Err.Clear
On Error Resume Next
    Rem If the color does not already exist, InDesign will generate an error.
    Set myColor = myDocument.Colors.Item("PageNumberRed")
    If Err.Number <> 0 Then
        Set myColor = myDocument.Colors.Add
        myColor.Name = "PageNumberRed"
        myColor.colorModel = idColorModel.idProcess
        myColor.ColorValue = Array(20, 100, 80, 10)
        Err.Clear
    End If
Rem restore normal error handling
On Error GoTo 0
Rem Next, set up some default styles.
Rem Create up a character style for the page numbers.
Err.Clear
On Error Resume Next
    Rem If the character style does not already exist, InDesign will generate an error.
    Set myCharacterStyle = myDocument.CharacterStyles.Item("page_number")
    If Err.Number <> 0 Then
        Set myCharacterStyle = myDocument.CharacterStyles.Add
        myCharacterStyle.Name = "page_number"
        Err.Clear
    End If
Rem restore normal error handling
On Error GoTo 0
myDocument.CharacterStyles.Item("page_number").FillColor = myDocument.Colors.Item("PageNumberRed")
Rem Create up a pair of paragraph styles for the page footer text.
Rem These styles have only basic formatting.
Err.Clear
On Error Resume Next
    Rem If the paragraph style does not already exist, InDesign will generate an error.
    Set myParagraphStyle = myDocument.ParagraphStyles.Item("footer_left")
    If Err.Number <> 0 Then
        Set myParagraphStyle = myDocument.ParagraphStyles.Add
        myParagraphStyle.Name = "footer_left"
        myParagraphStyle.PointSize = 11
        myParagraphStyle.Leading = 14
        Err.Clear
    End If
Rem restore normal error handling
On Error GoTo 0
Err.Clear
On Error Resume Next
    Rem If the paragraph style does not already exist, InDesign will generate an error.
    Set myParagraphStyle = myDocument.ParagraphStyles.Item("footer_right")
    If Err.Number <> 0 Then
        Set myParagraphStyle = myDocument.ParagraphStyles.Add
        myParagraphStyle.Name = "footer_right"
        myParagraphStyle.BasedOn = myDocument.ParagraphStyles.Item("footer_left")
        myParagraphStyle.Justification = idJustification.idRightAlign
        myParagraphStyle.PointSize = 11
        myParagraphStyle.Leading = 14
        Err.Clear
    End If
Rem restore normal error handling
On Error GoTo 0
Rem Create a layer for guides.
Err.Clear
On Error Resume Next
    Set myLayer = myDocument.Layers.Item("GuideLayer")
    If Err.Number <> 0 Then
        Set myLayer = myDocument.Layers.Add
        myLayer.Name = "GuideLayer"
        Err.Clear
    End If
Rem restore normal error handling
On Error GoTo 0
Rem Create a layer for the footer items.
Err.Clear
On Error Resume Next
    Set myLayer = myDocument.Layers.Item("Footer")
    If Err.Number <> 0 Then
        Set myLayer = myDocument.Layers.Add
        myLayer.Name = "Footer"
        Err.Clear
    End If
Rem restore normal error handling
On Error GoTo 0
Rem Create a layer for the slug items.
Err.Clear
On Error Resume Next
    Set myLayer = myDocument.Layers.Item("Slug")
    If Err.Number <> 0 Then
        Set myLayer = myDocument.Layers.Add
        myLayer.Name = "Slug"
        Err.Clear
    End If
Rem restore normal error handling
On Error GoTo 0
Rem Create a layer for the body text.
Err.Clear
On Error Resume Next
    Set myLayer = myDocument.Layers.Item("BodyText")
    If Err.Number <> 0 Then
        Set myLayer = myDocument.Layers.Add
        myLayer.Name = "BodyText"
        Err.Clear
    End If
Rem restore normal error handling
On Error GoTo 0
With myDocument.ViewPreferences
    .RulerOrigin = idRulerOrigin.idPageOrigin
    .HorizontalMeasurementUnits = idMeasurementUnits.idPoints
    .VerticalMeasurementUnits = idMeasurementUnits.idPoints
End With
Rem Document baseline grid and document grid
With myDocument.GridPreferences
    .BaselineStart = 56
    .BaselineDivision = 14
    .BaselineGridShown = False
    .HorizontalGridlineDivision = 14
    .HorizontalGridSubdivision = 5
    .VerticalGridlineDivision = 14
    .VerticalGridSubdivision = 5
    .DocumentGridShown = False
End With
Rem Document XMP information.
With myDocument.MetadataPreferences
    .Author = "Olav Martin Kvern"
    .CopyrightInfoURL = "http:rem www.adobe.com"
    .CopyrightNotice = "This document is not copyrighted."
    .CopyrightStatus = idCopyrightStatus.idNo
    .Description = "Example 7 x 9 book layout"
    .DocumentTitle = "Example"
    .JobName = "7 x 9 book layout template"
    .Keywords = Array("7 x 9", "book", "template")
    .CreateContainerItem "http://ns.adobe.com/xap/1.0/", "email"
    .SetProperty "http://ns.adobe.com/xap/1.0/", "email/*[1]", "okvern@adobe.com"
End With
Rem Set up the master spread.
With myDocument.MasterSpreads.Item(1)
    With .Pages.Item(1)
        Rem Left and right are reversed for left-hand pages (becoming "inside" and "outside"--
        Rem this is also true in the InDesign user interface).
        myTopMargin = .MarginPreferences.Top
        myBottomMargin = myDocument.DocumentPreferences.PageHeight - .MarginPreferences.Bottom
        myRightMargin = myDocument.DocumentPreferences.PageWidth - .MarginPreferences.Left
        myLeftMargin = .MarginPreferences.Right
        With .Guides.Add
            .ItemLayer = myDocument.Layers.Item("GuideLayer")
            .Orientation = idHorizontalOrVertical.idVertical
            .Location = myLeftMargin
        End With
        With .Guides.Add
            .ItemLayer = myDocument.Layers.Item("GuideLayer")
            .Orientation = idHorizontalOrVertical.idVertical
            .Location = myRightMargin
        End With
        With .Guides.Add
            .ItemLayer = myDocument.Layers.Item("GuideLayer")
            .Orientation = idHorizontalOrVertical.idHorizontal
            .Location = myTopMargin
            .FitToPage = False
        End With
        With .Guides.Add
            .ItemLayer = myDocument.Layers.Item("GuideLayer")
            .Orientation = idHorizontalOrVertical.idHorizontal
            .Location = myBottomMargin
            .FitToPage = False
        End With
        With .Guides.Add
            .ItemLayer = myDocument.Layers.Item("GuideLayer")
            .Orientation = idHorizontalOrVertical.idHorizontal
            .Location = myBottomMargin + 14
            .FitToPage = False
        End With
        With .Guides.Add
            .ItemLayer = myDocument.Layers.Item("GuideLayer")
            .Orientation = idHorizontalOrVertical.idHorizontal
            .Location = myBottomMargin + 28
            .FitToPage = False
        End With
        Set myLeftFooter = .TextFrames.Add
        myLeftFooter.Move , Array(1, 1)
        myLeftFooter.ItemLayer = myDocument.Layers.Item("Footer")
        myLeftFooter.GeometricBounds = Array(myBottomMargin + 14, .MarginPreferences.Right, myBottomMargin + 28, myRightMargin)
        myLeftFooter.ParentStory.InsertionPoints.Item(1).Contents = idSpecialCharacters.idSectionMarker
        myLeftFooter.ParentStory.InsertionPoints.Item(1).Contents = idSpecialCharacters.idEmSpace
        myLeftFooter.ParentStory.InsertionPoints.Item(1).Contents = idSpecialCharacters.idAutoPageNumber
        myLeftFooter.ParentStory.Characters.Item(1).AppliedCharacterStyle = myDocument.CharacterStyles.Item("page_number")
        myLeftFooter.ParentStory.Paragraphs.Item(1).ApplyParagraphStyle myDocument.ParagraphStyles.Item("footer_left"), False
        Rem Slug information.
        myDate = Date
        With myDocument.MetadataPreferences
            myString = "Author:" & vbTab & .Author & vbTab & "Description:" & vbTab & .Description & vbCr & _
            "Creation Date:" & vbTab & myDate & vbTab & "Email Contact" & vbTab & .GetProperty("http://ns.adobe.com/xap/1.0/", "email/*[1]")
        End With
        Set myLeftSlug = .TextFrames.Add
        myLeftSlug.Move , Array(1, 1)
        myLeftSlug.ItemLayer = myDocument.Layers.Item("Slug")
        myLeftSlug.GeometricBounds = Array(myDocument.DocumentPreferences.PageHeight + 36, .MarginPreferences.Right, myDocument.DocumentPreferences.PageHeight + 144, myRightMargin)
        myLeftSlug.Contents = myString
        myLeftSlug.ParentStory.Texts.Item(1).ConvertToTable
        Rem Body text master text frame.
        Set myLeftFrame = .TextFrames.Add
        myLeftFrame.ItemLayer = myDocument.Layers.Item("BodyText")
        myLeftFrame.GeometricBounds = Array(.MarginPreferences.Top, .MarginPreferences.Right, myBottomMargin, myRightMargin)
    End With
    With .Pages.Item(2)
        myTopMargin = .MarginPreferences.Top
        myBottomMargin = myDocument.DocumentPreferences.PageHeight - .MarginPreferences.Bottom
        myRightMargin = myDocument.DocumentPreferences.PageWidth - .MarginPreferences.Right
        myLeftMargin = .MarginPreferences.Left
        With .Guides.Add
            .ItemLayer = myDocument.Layers.Item("GuideLayer")
            .Orientation = idHorizontalOrVertical.idVertical
            .Location = myLeftMargin
        End With
        With .Guides.Add
            .ItemLayer = myDocument.Layers.Item("GuideLayer")
            .Orientation = idHorizontalOrVertical.idVertical
            .Location = myRightMargin
        End With
        Set myRightFooter = .TextFrames.Add
        myRightFooter.Move , Array(1, 1)
        myRightFooter.ItemLayer = myDocument.Layers.Item("Footer")
        myRightFooter.GeometricBounds = Array(myBottomMargin + 14, .MarginPreferences.Left, myBottomMargin + 28, myRightMargin)
        myRightFooter.ParentStory.InsertionPoints.Item(1).Contents = idSpecialCharacters.idAutoPageNumber
        myRightFooter.ParentStory.InsertionPoints.Item(1).Contents = idSpecialCharacters.idEmSpace
        myRightFooter.ParentStory.InsertionPoints.Item(1).Contents = idSpecialCharacters.idSectionMarker
        myRightFooter.ParentStory.Characters.Item(-1).AppliedCharacterStyle = myDocument.CharacterStyles.Item("page_number")
        myRightFooter.ParentStory.Paragraphs.Item(1).ApplyParagraphStyle myDocument.ParagraphStyles.Item("footer_right"), False
        Rem Slug information.
        Set myRightSlug = .TextFrames.Add
        myRightSlug.Move , Array(1, 1)
        myRightSlug.ItemLayer = myDocument.Layers.Item("Slug")
        myRightSlug.GeometricBounds = Array(myDocument.DocumentPreferences.PageHeight + 36, myLeftMargin, myDocument.DocumentPreferences.PageHeight + 144, myRightMargin)
        myRightSlug.Contents = myString
        myRightSlug.ParentStory.Texts.Item(1).ConvertToTable
        Rem Body text master text frame.
        Set myRightFrame = .TextFrames.Add
        myRightFrame.ItemLayer = myDocument.Layers.Item("BodyText")
        myRightFrame.GeometricBounds = Array(.MarginPreferences.Top, .MarginPreferences.Left, myBottomMargin, myRightMargin)
        myRightFrame.PreviousTextFrame = myLeftFrame
    End With
End With
Rem Add section marker text--this text will appear in the footer.
myDocument.Sections.Item(1).Marker = "Section 1"

Rem Save the file (fill in a valid file path on your system).
Set filesys = CreateObject("Scripting.FileSystemObject")
myFolderPath = "c:\ServerTestFiles"
If Not filesys.FolderExists(myFolderPath) Then
    filesys.CreateFolder(myFolderPath)
End If
Set myDocument = myDocument.Save(myFolderPath & "\" & "myTestDocument.indd")

Rem Close the document
myDocument.Close
