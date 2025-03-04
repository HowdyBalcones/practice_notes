Rem TextDefaults.vbs
Rem An InCopy VBScript
Rem
Rem Sets the text defaults of a new document, which set the default formatting
Rem for all new text frames. Existing text frames are unaffected.
main
Function main()
	Set myInCopy = CreateObject("InCopy.Application.2024")
	mySetup myInCopy
	mySnippet myInCopy
	myTeardown myInCopy
End Function
Function mySetup(myInCopy)
	myInCopy.ViewPreferences.HorizontalMeasurementUnits = idMeasurementUnits.idPoints
	myInCopy.ViewPreferences.VerticalMeasurementUnits = idMeasurementUnits.idPoints
End Function
Function mySnippet(myInCopy)
	Rem To set the application text formatting defaults, replace "myInCopy"
	Rem with a reference to a document in the following lines.
	With myInCopy.TextDefaults
	    .AlignToBaseline = True
	    Rem Because the font might not be available, it's usually best
	    Rem to trap errors using "On Error Resume Next" error handling.
	    Rem Fill in the name of a font on your system.
	    Err.Clear
	    On Error Resume Next
	    .AppliedFont = myInDesign.Fonts.Item("Minion Pro")
	    If Err.Number <> 0 Then
	        Err.Clear
	    End If
	    On Error GoTo 0
	    Rem Because the font style might not be available, it's usually best
	    Rem to trap errors using "On Error Resume Next" error handling.
	    Err.Clear
	    On Error Resume Next
	    .FontStyle = "Regular"
	    If Err.Number <> 0 Then
	        Err.Clear
	    End If
	    On Error GoTo 0
	
	    Rem Because the language might not be available, it's usually best
	    Rem to trap errors using "On Error Resume Next" error handling.
	    Err.Clear
	    On Error Resume Next
	    .AppliedLanguage = "English: USA"
	    If Err.Number <> 0 Then
	        Err.Clear
	    End If
	    On Error GoTo 0
	    .AutoLeading = 100
	    .BalanceRaggedLines = False
	    .BaselineShift = 0
	    .Capitalization = idCapitalization.idNormal
	    .Composer = "Adobe Paragraph Composer"
	    .DesiredGlyphScaling = 100
	    .DesiredLetterSpacing = 0
	    .DesiredWordSpacing = 100
	    .DropCapCharacters = 0
	    If .DropCapCharacters <> 0 Then
	        .DropCapLines = 3
	        Rem Assumes that the application has a default character style named "myDropCap"
	        .DropCapStyle = myInCopy.CharacterStyles.Item("myDropCap")
	    End If
	    .FillColor = myInCopy.Colors.Item("Black")
	    .FillTint = 100
	    .FirstLineIndent = 14
	    .GridAlignFirstLineOnly = False
	    .HorizontalScale = 100
	    .HyphenateAfterFirst = 3
	    .HyphenateBeforeLast = 4
	    .HyphenateCapitalizedWords = False
	    .HyphenateLadderLimit = 1
	    .HyphenateWordsLongerThan = 5
	    .Hyphenation = True
	    .HyphenationZone = 36
	    .HyphenWeight = 9
	    .Justification = idJustification.idLeftAlign
	    .KeepAllLinesTogether = False
	    .KeepLinesTogether = True
	    .KeepFirstLines = 2
	    .KeepLastLines = 2
	    .KeepWithNext = 0
	    .KerningMethod = "Optical"
	    .Leading = 14
	    .LeftIndent = 0
	    .Ligatures = True
	    .MaximumGlyphScaling = 100
	    .MaximumLetterSpacing = 0
	    .MaximumWordSpacing = 160
	    .MinimumGlyphScaling = 100
	    .MinimumLetterSpacing = 0
	    .MinimumWordSpacing = 80
	    .NoBreak = False
	    .OTFContextualAlternate = True
	    .OTFDiscretionaryLigature = True
	    .OTFFigureStyle = idOTFFigureStyle.idProportionalOldstyle
	    .OTFFraction = True
	    .OTFHistorical = True
	    .OTFOrdinal = False
	    .OTFSlashedZero = True
	    .OTFSwash = False
	    .OTFTitling = False
	    .OverprintFill = False
	    .OverprintStroke = False
	    .PointSize = 11
	    .Position = idPosition.idNormal
	    .RightIndent = 0
	    .RuleAbove = False
	    If .RuleAbove = True Then
	        .RuleAboveColor = myInCopy.Colors.Item("Black")
	        .RuleAboveGapColor = myInCopy.Swatches.Item("None")
	        .RuleAboveGapOverprint = False
	        .RuleAboveGapTint = 100
	        .RuleAboveLeftIndent = 0
	        .RuleAboveLineWeight = 0.25
	        .RuleAboveOffset = 14
	        .RuleAboveOverprint = False
	        .RuleAboveRightIndent = 0
	        .RuleAboveTint = 100
	        .RuleAboveType = myInCopy.StrokeStyles.Item("Solid")
	        .RuleAboveWidth = idRuleWidth.idColumnWidth
	    End If
	    .RuleBelow = False
	    If .RuleBelow = True Then
	        .RuleBelowColor = myInCopy.Colors.Item("Black")
	        .RuleBelowGapColor = myInCopy.Swatches.Item("None")
	        .RuleBelowGapOverPrint = False
	        .RuleBelowGapTint = 100
	        .RuleBelowLeftIndent = 0
	        .RuleBelowLineWeight = 0.25
	        .RuleBelowOffset = 0
	        .RuleBelowOverPrint = False
	        .RuleBelowRightIndent = 0
	        .RuleBelowTint = 100
	        .RuleBelowType = myInCopy.StrokeStyles.Item("Solid")
	        .RuleBelowWidth = idRuleWidth.idColumnWidth
	    End If
	    .SingleWordJustification = idSingleWordJustification.idLeftAlign
	    .Skew = 0
	    .SpaceAfter = 0
	    .SpaceBefore = 0
	    .StartParagraph = idStartParagraph.idAnywhere
	    .StrikeThru = False
	    If .StrikeThru = True Then
	        .StrikeThroughColor = myInCopy.Colors.Item("Black")
	        .StrikeThroughGapColor = myInCopy.Swatches.Item("None")
	        .StrikeThroughGapOverprint = False
	        .StrikeThroughGapTint = 100
	        .StrikeThroughOffset = 3
	        .StrikeThroughOverprint = False
	        .StrikeThroughTint = 100
	        .StrikeThroughType = myInCopy.StrokeStyles.Item("Solid")
	        .StrikeThroughWeight = 0.25
	    End If
	    .StrokeColor = myInCopy.Swatches.Item("None")
	    .StrokeTint = 100
	    .StrokeWeight = 0
	    .Tracking = 0
	    .Underline = False
	    If .Underline = True Then
	        .UnderlineColor = myInCopy.Colors.Item("Black")
	        .UnderlineGapColor = myInCopy.Swatches.Item("None")
	        .UnderlineGapOverprint = False
	        .UnderlineGapTint = 100
	        .UnderlineOffset = 3
	        .UnderlineOverprint = False
	        .UnderlineTint = 100
	        .UnderlineType = myInCopy.StrokeStyles.Item("Solid")
	        .UnderlineWeight = 0.25
	    End If
	    .VerticalScale = 100
	End With
End Function
Function myTeardown(myInCopy)
End Function