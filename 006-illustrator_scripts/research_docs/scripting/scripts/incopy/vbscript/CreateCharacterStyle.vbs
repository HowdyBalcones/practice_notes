Rem CreateCharacterStyle.vbs
Rem An InCopy VBScript
Rem
Rem Creates a complete character style based on the first insertion point of the selected text.
Rem When you create a character style "by example" using InCopy's user interface, only those
Rem formatting attributes of the selection which differ from the underlying formatting are
Rem defined in the character style. While this makes InCopy's character styles very flexible, it
Rem differs from the way that other applications define character styles. By defining every attribute,
Rem this script creates character styles that more closely resemble those found in other applications.
Rem
main
Function main()
	Set myInCopy = CreateObject("InCopy.Application.2024")
	Rem Set the user interaction level to allow the display of dialog boxes and alerts.
	myInCopy.ScriptPreferences.UserInteractionLevel = idUserInteractionLevels.idInteractWithAll
	If myInCopy.Documents.Count <> 0 Then
	    If myInCopy.Selection.Count = 1 Then
	        Select Case TypeName(myInCopy.Selection.Item(1))
		    Case "InsertionPoint", "Character", "Word", "TextStyleRange", "Line", "Paragraph", "TextColumn", "Text"
	                Set mySourceText = myInCopy.Selection.Item(1)
	                myDisplayDialog myInCopy, mySourceText
	            Case Else
	                MsgBox "The selected object is not a text object. Select some text and try again."
	        End Select
	    Else
	         MsgBox "Please select some text and try again."
	    End If
	Else
	    MsgBox "No documents are open. Please open a document, select some text, and try again."
	End If
End Function
Rem Display a dialog box.
Function myDisplayDialog(myInCopy, mySourceText)
    Set myDialog = myInCopy.Dialogs.Add
    myDialog.Name = "CreateCharacterStyle"
    With myDialog.DialogColumns.Add
        With .BorderPanels.Add
            With .StaticTexts.Add
                .StaticLabel = "Character Style Name:"
            End With
            With .DialogColumns.Add
                Set myCharacterStyleNameField = .TextEditboxes.Add
                myCharacterStyleNameField.EditContents = "myNewCharacterStyle"
            End With
        End With
    End With
    myResult = myDialog.Show
    If myResult = True Then
        myCharacterStyleName = myCharacterStyleNameField.EditContents
        myDialog.Destroy
        myDefineCharacterStyle myInCopy, mySourceText, myCharacterStyleName
    Else
       myDialog.Destroy
    End If
End Function
Function myDefineCharacterStyle(myInCopy, mySourceText, myCharacterStyleName)
    Set myDocument = myInCopy.ActiveDocument
    Rem Create the character style if it does not already exist. If the character style
    Rem already exists, it will be redefined based on the current selection.
    Err.Clear
    On Error Resume Next
    Set myCharacterStyle = myDocument.CharacterStyles.Item(myCharacterStyleName)
    If Err.Number <> 0 Then
        Set myCharacterStyle = myDocument.CharacterStyles.Add
        myCharacterStyle.Name = myCharacterStyleName
        Err.Clear
    End If
    On Error Goto 0
    myCharacterStyle.AppliedFont = mySourceText.AppliedFont
    myCharacterStyle.FontStyle = mySourceText.FontStyle
    myCharacterStyle.PointSize = mySourceText.PointSize
    myCharacterStyle.Leading = mySourceText.Leading
    myCharacterStyle.AppliedLanguage = mySourceText.AppliedLanguage
    myCharacterStyle.KerningMethod = mySourceText.KerningMethod
    myCharacterStyle.Tracking = mySourceText.Tracking
    myCharacterStyle.Capitalization = mySourceText.Capitalization
    myCharacterStyle.Position = mySourceText.Position
    myCharacterStyle.Ligatures = mySourceText.Ligatures
    myCharacterStyle.NoBreak = mySourceText.NoBreak
    myCharacterStyle.HorizontalScale = mySourceText.HorizontalScale
    myCharacterStyle.VerticalScale = mySourceText.VerticalScale
    myCharacterStyle.BaselineShift = mySourceText.BaselineShift
    myCharacterStyle.Skew = mySourceText.Skew
    myCharacterStyle.FillColor = mySourceText.FillColor
    myCharacterStyle.FillTint = mySourceText.FillTint
    myCharacterStyle.StrokeTint = mySourceText.StrokeTint
    myCharacterStyle.StrokeWeight = mySourceText.StrokeWeight
    myCharacterStyle.OverprintStroke = mySourceText.OverprintStroke
    myCharacterStyle.OverprintFill = mySourceText.OverprintFill
    myCharacterStyle.OTFFigureStyle = mySourceText.OTFFigureStyle
    myCharacterStyle.OTFOrdinal = mySourceText.OTFOrdinal
    myCharacterStyle.OTFFraction = mySourceText.OTFFraction
    myCharacterStyle.OTFDiscretionaryLigature = mySourceText.OTFDiscretionaryLigature
    myCharacterStyle.OTFTitling = mySourceText.OTFTitling
    myCharacterStyle.OTFContextualAlternate = mySourceText.OTFContextualAlternate
    myCharacterStyle.OTFSwash = mySourceText.OTFSwash
    myCharacterStyle.OTFSlashedZero = mySourceText.OTFSlashedZero
    myCharacterStyle.OTFHistorical = mySourceText.OTFHistorical
    myCharacterStyle.OTFStylisticSets = mySourceText.OTFStylisticSets
    myCharacterStyle.StrikeThru = mySourceText.StrikeThru
    If mySourceText.StrikeThru = True Then
        myCharacterStyle.StrikeThroughColor = mySourceText.StrikeThroughColor
        myCharacterStyle.StrikeThroughGapColor = mySourceText.StrikeThroughGapColor
        myCharacterStyle.StrikeThroughGapOverprint = mySourceText.StrikeThroughGapOverprint
        myCharacterStyle.StrikeThroughGapTint = mySourceText.StrikeThroughGapTint
        myCharacterStyle.StrikeThroughOffset = mySourceText.StrikeThroughOffset
        myCharacterStyle.StrikeThroughOverprint = mySourceText.StrikeThroughOverprint
        myCharacterStyle.StrikeThroughTint = mySourceText.StrikeThroughTint
        myCharacterStyle.StrikeThroughType = mySourceText.StrikeThroughType
        myCharacterStyle.StrikeThroughWeight = mySourceText.StrikeThroughWeight
    End If
    myCharacterStyle.StrokeColor = mySourceText.StrokeColor
    myCharacterStyle.StrokeTint = mySourceText.StrokeTint
    myCharacterStyle.StrokeWeight = mySourceText.StrokeWeight
    myCharacterStyle.Tracking = mySourceText.Tracking
    myCharacterStyle.Underline = mySourceText.Underline
    If mySourceText.Underline = True Then
        myCharacterStyle.UnderlineColor = mySourceText.UnderlineColor
        myCharacterStyle.UnderlineGapColor = mySourceText.UnderlineGapColor
        myCharacterStyle.UnderlineGapOverprint = mySourceText.UnderlineGapOverprint
        myCharacterStyle.UnderlineGapTint = mySourceText.UnderlineGapTint
            myCharacterStyle.UnderlineOffset = mySourceText.UnderlineOffset
        myCharacterStyle.UnderlineOverprint = mySourceText.UnderlineOverprint
        myCharacterStyle.UnderlineTint = mySourceText.UnderlineTint
        myCharacterStyle.UnderlineType = mySourceText.UnderlineType
        myCharacterStyle.UnderlineWeight = mySourceText.UnderlineWeight
    End If
    myCharacterStyle.VerticalScale = mySourceText.VerticalScale
End Function
