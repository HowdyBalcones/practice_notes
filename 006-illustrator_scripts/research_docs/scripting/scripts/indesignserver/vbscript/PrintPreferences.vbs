Rem PrintPreferences.vbs
Rem An InDesign Server VBScript
Rem Sets the print preferences of the current document.
Rem The comments in this section refer to various panels of the InDesign Print dialog box.
Set myInDesignServer = CreateObject("InDesignServer.Application")
If myInDesignServer.Documents.Count > 0 Then
    Set myDocument = myInDesignServer.Documents.Item(1)
    With myDocument.PrintPreferences
        Rem Properties corresponding to the controls in the General panel of the Print dialog box.
        Rem ActivePrinterPreset is ignored in this example--we'll set our own print preferences.
        Rem printer can be either a string (the name of the printer) or idPrinter.idPostscriptFile.
        .Printer = "Adobe PDF"
        Rem If the printer property is the name of a printer, then the ppd property
        Rem is locked (and will return an error if you try to set it).
        Rem ppd = "AGFA-SelectSet5000SF"
        Rem If the printer property is set to Printer.postscript file, the copies
        Rem property is unavailable. Attempting to set it will generate an error.
        .Copies = 1
        Rem If the printer property is set to Printer.postscript file, or if the
        Rem selected printer does not support collation, then the collating
        Rem property is unavailable. Attempting to set it will generate an error.
        Rem collating = false
        .ReverseOrder = False
        Rem pageRange can be either PageRange.allPages or a page range string.
        .PageRange = idPageRange.idAllPages
        .PrintSpreads = False
        .PrintMasterPages = False
        Rem If the printer property is set to Printer.postScript file, then
        Rem the printFile property contains the file path to the output file.
        Rem printFile = "/c/test.ps"
        .Sequence = idSequences.idAll
        Rem If trapping is set to either idTrapping.idApplicationBuiltIn or idTrapping.idAdobeInRIP,
        Rem then setting the following properties will produce an error.
        If (.ColorOutput = idColorOutputModes.idInRIPSeparations) Or _
        (.ColorOutput = idColorOutputModes.idSeparations) Then
            If .Trapping = idTrapping.idOff Then
                .PrintBlankPages = False
                .PrintGuidesGrids = False
                .PrintNonprinting = False
            End If
        End If
        Rem --------------------------------------------------------------------------------
        Rem Properties corresponding to the controls in the Setup panel of the Print dialog box.
        Rem --------------------------------------------------------------------------------
        .PaperSize = idPaperSizes.idCustom
        Rem Page width and height are ignored if paperSize is not PaperSizes.custom.
        Rem .PaperHeight = 1200
        Rem .PaperWidth = 1200
        .PrintPageOrientation = idPrintPageOrientation.idPortrait
        .PagePosition = idPagePositions.idCentered
        .PaperGap = 0
        .PaperOffset = 0
        .PaperTransverse = False
        .ScaleHeight = 100
        .ScaleWidth = 100
        .ScaleMode = idScaleModes.idScaleWidthHeight
        .ScaleProportional = True
        Rem If trapping is set to either idTrapping.idApplicationBuiltIn or idTrapping.idAdobeInRIP,
        Rem then setting the following properties will produce an error.
        If (.ColorOutput = idColorOutputModes.idInRIPSeparations) Or _
        (.ColorOutput = idColorOutputModes.idSeparations) Then
            If .Trapping = idTrapping.idOff Then
                .TextAsBlack = False
                .Thumbnails = False
                Rem The following properties is not needed because thumbnails is set to false.
                Rem thumbnailsPerPage = 4
                .Tile = False
                Rem The following properties are not needed because tile is set to false.
                Rem .TilingOverlap = 12
                Rem .TilingType = TilingTypes.auto
            End If
        End If
        Rem --------------------------------------------------------------------------------
        Rem Properties corresponding to the controls in the Marks and Bleed panel of the Print dialog box.
        Rem --------------------------------------------------------------------------------
        Rem Set the following property to true to print all printer's marks.
        Rem allPrinterMarks = true
        .UseDocumentBleedToPrint = False
        Rem If useDocumentBleedToPrint = false then setting any of the  bleed properties
        Rem will result in an error.
        Rem Get the bleed amounts from the document's bleed and add a bit.
        .BleedBottom = myDocument.DocumentPreferences.DocumentBleedBottomOffset + 3
        .BleedTop = myDocument.DocumentPreferences.DocumentBleedTopOffset + 3
        .BleedInside = myDocument.DocumentPreferences.DocumentBleedInsideOrLeftOffset + 3
        .BleedOutside = myDocument.DocumentPreferences.DocumentBleedOutsideOrRightOffset + 3
        Rem If any bleed area is greater than zero, then print the bleed marks.
        If ((.BleedBottom = 0) And (.BleedTop = 0) And (.BleedInside = 0) And (.BleedOutside = 0)) Then
            .BleedMarks = True
        Else
            .BleedMarks = False
        End If
        .ColorBars = True
        .CropMarks = True
        .IncludeSlugToPrint = False
        .MarkLineWeight = idMarkLineWeight.idP125pt
        .MarkOffset = 6
        Rem .MarkType = MarkTypes.default
        .PageInformationMarks = True
        .RegistrationMarks = True
        Rem --------------------------------------------------------------------------------
        Rem Properties corresponding to the controls in the Output panel of the Print dialog box.
        Rem --------------------------------------------------------------------------------
        .ColorOutput = idColorOutputModes.idSeparations
        .Negative = True
        Rem Note the lowercase "i" in "Builtin"
        .Trapping = idTrapping.idApplicationBuiltin
        .Screening = "175 lpi/2400 dpi"
        .Flip = idFlip.idNone
        Rem The following options are only applicable if trapping is set to
        Rem idTrapping.idAdobeInRIP.
        If .Trapping = idTrapping.idAdobeInRIP Then
            .PrintBlack = True
            .PrintCyan = True
            .PrintMagenta = True
            .PrintYellow = True
        End If
        Rem Only change the ink angle and frequency when you want to override the
        Rem screening set by the screening specified by the screening property.
        Rem .BlackAngle = 45
        Rem .BlackFrequency = 175
        Rem .CyanAngle = 15
        Rem .CyanFrequency = 175
        Rem .MagentaAngle = 75
        Rem .MagentaFreqency = 175
        Rem .YellowAngle = 0
        Rem .YellowFrequency = 175
        Rem The following properties are not needed (because colorOutput is set to separations).
        Rem .CompositeAngle = 45
        Rem .CompositeFrequency = 175
        Rem .SimulateOverprint = false
        Rem --------------------------------------------------------------------------------
        Rem Properties corresponding to the controls in the Graphics panel of the Print dialog box.
        Rem --------------------------------------------------------------------------------
        .SendImageData = idImageDataTypes.idAllImageData
        .FontDownloading = idFontDownloading.idComplete
        Err.Clear
        On Error Resume Next
            .DownloadPPDFonts = True
            .DataFormat = idDataFormat.idBinary
            .PostScriptLevel = idPostScriptLevels.idLevel3
            If Err.Number <> 0 Then
                Err.Clear
            End If
        On Error GoTo 0
        Rem --------------------------------------------------------------------------------
        Rem Properties corresponding to the controls in the Color Management panel of the Print dialog box.
        Rem --------------------------------------------------------------------------------
        Rem If the UseColorManagement property of myInDesignServer.ColorSettings is false,
        Rem attempting to set the following properties will return an error.
        Err.Clear
        On Error Resume Next
            .SourceSpace = SourceSpaces.useDocument
            .Intent = RenderingIntent.useColorSettings
            .CRD = ColorRenderingDictionary.useDocument
            .Profile = Profile.postscriptCMS
            If Err.Number <> 0 Then
                Err.Clear
            End If
        On Error GoTo 0
        Rem --------------------------------------------------------------------------------
        Rem Properties corresponding to the controls in the Advanced panel of the Print dialog box.
        Rem --------------------------------------------------------------------------------
        .OPIImageReplacement = False
        .OmitBitmaps = False
        .OmitEPS = False
        .OmitPDF = False
        Rem The following line assumes that you have a flattener preset named "high quality flattener".
        Err.Clear
        On Error Resume Next
            .FlattenerPresetName = "high quality flattener"
            If Err.Number <> 0 Then
                Err.Clear
            End If
        On Error GoTo 0
        .IgnoreSpreadOverrides = False
    End With
Else
    returnValue = "No documents are open."
End If
