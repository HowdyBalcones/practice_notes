Rem ExportPDFWithOptions.vbs
Rem An InDesign Server VBScript
Rem Sets PDF export options, then exports the current document as PDF.
Set myInDesignServer = CreateObject("InDesignServer.Application")
If myInDesignServer.Documents.Count > 0 Then
    Set myDocument = myInDesignServer.Documents.Item(1)
    myInDesignServer.ViewPreferences.HorizontalMeasurementUnits = idMeasurementUnits.idPoints
    myInDesignServer.ViewPreferences.VerticalMeasurementUnits = idMeasurementUnits.idPoints
    With myInDesignServer.PDFExportPreferences
        Rem Basic PDF output options.
        .PageRange = idPageRange.idAllPages
        .AcrobatCompatibility = idAcrobatCompatibility.idAcrobat6
        .ExportGuidesAndGrids = False
        .ExportLayers = False
        .ExportNonprintingObjects = False
        .ExportReaderSpreads = False
        .GenerateThumbnails = False
        On Error Resume Next
        .IgnoreSpreadOverrides = False
        .IncludeICCProfiles = True
        On Error GoTo 0
        .IncludeBookmarks = True
        .IncludeHyperlinks = True
        .IncludeSlugWithPDF = False
        .IncludeStructure = False
        .InteractiveElementsOption = idDoNotInclude
        Rem Setting subsetFontsBelow to zero disallows font subsetting
        Rem set subsetFontsBelow to some other value to use font subsetting.
        .SubsetFontsBelow = 0
        Rem Bitmap compression/sampling/quality options (note the additional "s" in "compression").
        .ColorBitmapCompression = idBitmapCompression.idZip
        .ColorBitmapQuality = idCompressionQuality.idEightBit
        .ColorBitmapSampling = idSampling.idNone
        Rem ThresholdToCompressColor is not needed in this example.
        Rem ColorBitmapSamplingDPI is not needed when ColorBitmapSampling is set to none.
        .GrayscaleBitmapCompression = idBitmapCompression.idZip
        .GrayscaleBitmapQuality = idCompressionQuality.idEightBit
        .GrayscaleBitmapSampling = idSampling.idNone
        Rem ThresholdToCompressGray is not needed in this example.
        Rem GrayscaleBitmapSamplingDPI is not needed when GrayscaleBitmapSampling is set to none.
        .MonochromeBitmapCompression = idBitmapCompression.idZip
        .MonochromeBitmapSampling = idSampling.idNone
        Rem ThresholdToCompressMonochrome is not needed in this example.
        Rem MonochromeBitmapSamplingDPI is not needed when MonochromeBitmapSampling is set to none.
        Rem Other compression options.
        .CompressionType = idPDFCompressionType.idCompressNone
        .CompressTextAndLineArt = True
        .CropImagesToFrames = True
        .OptimizePDF = True
        Rem Printers marks and prepress options.
        Rem Get the bleed amounts from the document's bleed.
        .BleedBottom = myDocument.DocumentPreferences.DocumentBleedBottomOffset
        .BleedTop = myDocument.DocumentPreferences.DocumentBleedTopOffset
        .BleedInside = myDocument.DocumentPreferences.DocumentBleedInsideOrLeftOffset
        .BleedOutside = myDocument.DocumentPreferences.DocumentBleedOutsideOrRightOffset
        Rem If any bleed area is greater than zero, then export the bleed marks.
        If ((.BleedBottom = 0) And (.BleedTop = 0) And (.BleedInside = 0) And (.BleedOutside = 0)) Then
            .BleedMarks = True
        Else
            .BleedMarks = False
        End If
        .ColorBars = True
        Rem ColorTileSize and GrayTileSize are only used when
        Rem the export format is set to JPEG2000.
        Rem .ColorTileSize = 256
        Rem .GrayTileSize = 256
        .CropMarks = True
        .OmitBitmaps = False
        .OmitEPS = False
        .OmitPDF = False
        .PageInformationMarks = True
        .PageMarksOffset = 12
        .PDFColorSpace = idPDFColorSpace.idUnchangedColorSpace
        .PDFMarkType = idMarkTypes.idDefault
        .PrinterMarkWeight = idPDFMarkWeight.idP125pt
        .RegistrationMarks = True
        On Error Resume Next
        .SimulateOverprint = False
        On Error GoTo 0
        .UseDocumentBleedWithPDF = True
        Rem Set viewPDF to true to open the PDF in Acrobat or Adobe Reader.
        .ViewPDF = False
    End With
    
    Rem Now export the current document. You'll have to fill in your own file path.
    Set filesys = CreateObject("Scripting.FileSystemObject")
    myFolderPath = "c:\ServerTestFiles"
    If Not filesys.FolderExists(myFolderPath) Then
        filesys.CreateFolder(myFolderPath)
    End If
    myFile = myFolderPath & "\" & "myTestDocument.pdf"
    myDocument.Export idExportFormat.idPDFType, myFile

Else
    returnValue = "No documents are open."
End If
