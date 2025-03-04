Rem ApplicationTextDefaults.vbs
Rem An InDesign Server VBScript
Rem Sets the application text defaults, which will become the text formatting
Rem defaults for all new documents. Existing documents will remain unchanged.
Set myInDesignServer = CreateObject("InDesignServer.Application")
With myInDesignServer.TextDefaults
    Rem The following settings have a chance of generating
    Rem errors when the specific fonts, font styles, and/or
    Rem languages are not installed on your system. Disable
    Rem error handling to skip any errors.
    On Error Resume Next
        .AppliedFont = myInDesignServer.Fonts.Item("Minion Pro")
        .FontStyle = "Normal"
        .AppliedLanguage = "English: USA"
    Rem Reinstate normal error handling.
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
    Rem If DropCapCharacters = 0, then trying to set the DropCapLines
    Rem property will generate an error.
    If .DropCapCharacters <> 0 Then
        .DropCapLines = 3
        Rem Assumes that the application has a default
        Rem character style named "myDropCap"
        .DropCapStyle = myInDesignServer.CharacterStyles.Item("myDropCap")
    End If
    .FillColor = myInDesignServer.Colors.Item("Black")
    .FillTint = 100
    .FirstLineIndent = "14pt"
    .GradientFillAngle
    .GradientFillLength
    .GridAlignFirstLineOnly = False
    .HorizontalScale = 100
    .HyphenateAfterFirst = 3
    .HyphenateBeforeLast = 4
    .HyphenateCapitalizedWords = False
    .HyphenateLadderLimit = 1
    .HyphenateWordsLongerThan = 5
    .Hyphenation = True
    .HyphenationZone = "3p"
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
    Rem If RuleAbove is false, attempting to set some of the
    Rem rule above properties will generate an error. Though
    Rem we've set RuleAbove to false, we've included the properties
    Rem to provide a more complete example.
    If .RuleAbove = True Then
        .RuleAboveColor = myInDesignServer.Colors.Item("Black")
        .RuleAboveGapColor = myInDesignServer.Swatches.Item("None")
        .RuleAboveGapOverprint = False
        .RuleAboveGapTint = 100
        .RuleAboveLeftIndent = 0
        .RuleAboveLineWeight = 0.25
        .RuleAboveOffset = 14
        .RuleAboveOverprint = False
        .RuleAboveRightIndent = 0
        .RuleAboveTint = 100
        .RuleAboveType = myInDesignServer.StrokeStyles.Item("Solid")
        .RuleAboveWidth = idRuleWidth.idColumnWidth
    End If
    .RuleBelow = False
    Rem If RuleBelow is false, attempting to set some of the
    Rem rule below properties will generate an error. Though
    Rem we've set RuleBelow to false, we've included the properties
    Rem to provide a more complete example.
    If .RuleBelow = True Then
        .RuleBelowColor = myInDesignServer.Colors.Item("Black")
        .RuleBelowGapColor = myInDesignServer.Swatches.Item("None")
        .RuleBelowGapOverPrint = False
        .RuleBelowGapTint = 100
        .RuleBelowLeftIndent = 0
        .RuleBelowLineWeight = 0.25
        .RuleBelowOffset = 0
        .RuleBelowOverPrint = False
        .RuleBelowRightIndent = 0
        .RuleBelowTint = 100
        .RuleBelowType = myInDesignServer.StrokeStyles.Item("Solid")
        .RuleBelowWidth = idRuleWidth.idColumnWidth
    End If
    .SingleWordJustification = idSingleWordJustification.idLeftAlign
    .Skew = 0
    .SpaceAfter = 0
    .SpaceBefore = 0
    .StartParagraph = idStartParagraph.idAnywhere
    .StrikeThru = False
    Rem If StrikeThru is false, attempting to set some of the
    Rem strikethrough properties will generate an error. Though
    Rem we've set StrikeThru to false, we've included the properties
    Rem to provide a more complete example.
    If .StrikeThru = True Then
        .StrikeThroughColor = myInDesignServer.Colors.Item("Black")
        .StrikeThroughGapColor = myInDesignServer.Swatches.Item("None")
        .StrikeThroughGapOverprint = False
        .StrikeThroughGapTint = 100
        .StrikeThroughOffset = 3
        .StrikeThroughOverprint = False
        .StrikeThroughTint = 100
        .StrikeThroughType = myInDesignServer.StrokeStyles.Item("Solid")
        .StrikeThroughWeight = 0.25
    End If
    .StrokeColor = myInDesignServer.Swatches.Item("None")
    .StrokeTint = 100
    .StrokeWeight = 0
    .Tracking = 0
    .Underline = False
    Rem If Underline is false, attempting to set some of the
    Rem underline properties will generate an error. Though
    Rem we've set Underline to false, we've included the properties
    Rem to provide a more complete example.
    If .Underline = True Then
        .UnderlineColor = myInDesignServer.Colors.Item("Black")
        .UnderlineGapColor = myInDesignServer.Swatches.Item("None")
        .UnderlineGapOverprint = False
        .UnderlineGapTint = 100
        .UnderlineOffset = 3
        .UnderlineOverprint = False
        .UnderlineTint = 100
        .UnderlineType = myInDesignServer.StrokeStyles.Item("Solid")
        .UnderlineWeight = 0.25
    End If
    .VerticalScale = 100
End With