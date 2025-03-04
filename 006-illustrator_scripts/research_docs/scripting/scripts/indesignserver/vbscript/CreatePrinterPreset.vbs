Rem CreatePrinterPreset.vbs
Rem An InDesign Server VBScript
Rem Creates a new printer preset based on the print settings of the current document.
Rem Assumes you have a document open.
Set myInDesignServer = CreateObject("InDesignServer.Application")
If myInDesignServer.Documents.Count > 0 Then
    Rem If the preset does not already exist, then create it
    Rem otherwise, fill in the properties of the existing preset.
    Err.Clear
    On Error Resume Next
        Set myPreset = myInDesignServer.PrinterPresets.Item("myPreset")
        If Err.Number <> 0 Then
                Set myPreset = myInDesignServer.PrinterPresets.Add
                myPreset.Name = "myPreset"
                Err.Clear
        End If
    On Error GoTo 0
    With myInDesignServer.Documents.Item(1).PrintPreferences
        Rem Because many printing properties are dependent on other printing properties,
        Rem we've surrounded the property-setting lines on error resume next...on error goto 0
        Rem statements. These will make it easier for you to experiment with print preset settings,
        Rem but you'll need to remove them to find errors in your script if you use this example
        Rem as a template for your own scripts.
        Err.Clear
        On Error Resume Next
            myPreset.Printer = .Printer
            myPreset.ColorOutput = .ColorOutput
            myPreset.PPD = .PPD
            myPreset.Copies = .Copies
            myPreset.Collating = .Collating
            myPreset.ReverseOrder = .ReverseOrder
            myPreset.PageRange = .PageRange
            myPreset.PrintSpreads = .PrintSpreads
            myPreset.PrintMasterPages = .PrintMasterPages
            myPreset.PrintFile = .PrintFile
            myPreset.Sequence = .Sequence
            myPreset.PrintBlankPages = .PrintBlankPages
            myPreset.PrintGuidesGrids = .PrintGuidesGrids
            myPreset.PrintNonprinting = .PrintNonprinting
            myPreset.PaperSize = .PaperSize
            myPreset.PaperHeight = .PaperHeight
            myPreset.PaperWidth = .PaperWidth
            myPreset.PrintPageOrientation = .PrintPageOrientation
            myPreset.PagePosition = .PagePosition
            myPreset.PaperGap = .PaperGap
            myPreset.PaperOffset = .PaperOffset
            myPreset.PaperTransverse = .PaperTransverse
            myPreset.ScaleHeight = .ScaleHeight
            myPreset.ScaleWidth = .ScaleWidth
            myPreset.ScaleMode = .ScaleMode
            myPreset.ScaleProportional = .ScaleProportional
            myPreset.TextAsBlack = .TextAsBlack
            myPreset.Thumbnails = .Thumbnails
            myPreset.ThumbnailsPerPage = .ThumbnailsPerPage
            myPreset.Tile = .Tile
            myPreset.TilingType = .TilingType
            myPreset.TilingOverlap = .TilingOverlap
            myPreset.AllPrinterMarks = .AllPrinterMarks
            myPreset.UseDocumentBleedToPrint = .UseDocumentBleedToPrint
            myPreset.BleedBottom = .BleedBottom
            myPreset.BleedTop = .BleedTop
            myPreset.BleedInside = .BleedInside
            myPreset.BleedOutside = .BleedOutside
            myPreset.BleedMarks = .BleedMarks
            myPreset.ColorBars = .ColorBars
            myPreset.CropMarks = .CropMarks
            myPreset.IncludeSlugToPrint = .IncludeSlugToPrint
            myPreset.MarkLineWeight = .MarkLineWeight
            myPreset.MarkOffset = .MarkOffset
            myPreset.MarkType = .MarkType
            myPreset.PageInformationMarks = .PageInformationMarks
            myPreset.RegistrationMarks = .RegistrationMarks
            myPreset.Negative = .Negative
            myPreset.Trapping = .Trapping
            myPreset.Screening = .Screening
            myPreset.Flip = .Flip
            myPreset.PrintBlack = .PrintBlack
            myPreset.PrintCyan = .PrintCyan
            myPreset.PrintMagenta = .PrintMagenta
            myPreset.PrintYellow = .PrintYellow
            myPreset.BlackAngle = .BlackAngle
            myPreset.BlackFrequency = .BlackFrequency
            myPreset.CyanAngle = .CyanAngle
            myPreset.CyanFrequency = .CyanFrequency
            myPreset.MagentaAngle = .MagentaAngle
            myPreset.magentaFreqency = .magentaFreqency
            myPreset.YellowAngle = .YellowAngle
            myPreset.YellowFrequency = .YellowFrequency
            myPreset.CompositeAngle = .CompositeAngle
            myPreset.CompositeFrequency = .CompositeFrequency
            myPreset.SimulateOverprint = .SimulateOverprint
            myPreset.SendImageData = .SendImageData
            myPreset.FontDownloading = .FontDownloading
            myPreset.DownloadPPDFonts = .DownloadPPDFonts
            myPreset.DataFormat = .DataFormat
            myPreset.PostScriptLevel = .PostScriptLevel
            myPreset.SourceSpace = .SourceSpace
            myPreset.Intent = .Intent
            myPreset.CRD = .CRD
            myPreset.Profile = .Profile
            myPreset.OPIImageReplacement = .OPIImageReplacement
            myPreset.OmitBitmaps = .OmitBitmaps
            myPreset.OmitEPS = .OmitEPS
            myPreset.OmitPDF = .OmitPDF
            myPreset.FlattenerPresetName = .FlattenerPresetName
            myPreset.IgnoreSpreadOverrides = .IgnoreSpreadOverrides
        If Err.Number <> 0 Then
            Err.Clear
        End If
    On Error GoTo 0
    End With
Else
    returnValue = "No documents are open."
End If