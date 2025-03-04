//==============================================================================
// Export as XHTML sample script
//==============================================================================
// Usage:
//
// This script will export a document to XHTML.  Change the name and location of the source
// and destination below.

//------------------------------------------------------------------------------
// Preparation
//------------------------------------------------------------------------------
// replace this with the paths to your files
var outputFile = File('/c/ServerTestFiles/myTestDocument.html');
var documentToExport = File('/c/ServerTestFiles/myTestDocument.indd');

// open the document
var document = app.open(documentToExport, OpenOptions.OPEN_ORIGINAL, false);

if (documentToExport.exists)
{
    with (document.htmlExportPreferences)
    {
        //The unit of space.
        spaceUnit = SpaceUnitType.CSS_EM;
        //The unit of margin.
        marginUnit = SpaceUnitType.CSS_EM;

        applyImageAlignmentToAnchoredObjectSettings = true;

        bulletExportOption = BulletListExportOption.AS_TEXT;
        cssExportOption = StyleSheetExportOption.EMBEDDED_CSS;

        customImageSizeOption = ImageSizeOption.SIZE_RELATIVE_TO_PAGE_WIDTH;
        exportOrder = ExportOrder.LAYOUT_ORDER;

        exportSelection = false;

        //externalCSSPath = '';
        gifOptionsInterlaced = true;
        gifOptionsPalette = GIFOptionsPalette.WINDOWS_PALETTE;
        ignoreObjectConversionSettings = true;

        imageAlignment = ImageAlignmentType.ALIGN_CENTER;
        imageConversion = ImageConversion.AUTOMATIC;
        imageExportOption = ImageExportOption.ORIGINAL_IMAGE;
        imageExportResolution = ImageResolution.PPI_150;
        //imageExtension = ''
        imageSpaceAfter = 3;
        imageSpaceBefore = 3;
        includeCSSDefinition = true;

        jpegOptionsFormat = JPEGOptionsFormat.BASELINE_ENCODING;
        jpegOptionsQuality = JPEGOptionsQuality.HIGH;

        leftMargin = 5;
        rightMargin = 5;
        topMargin = 5;
        bottomMargin = 5;

        level = 5;	

        numberedListExportOption = NumberedListExportOption.AS_TEXT;

        preserveLayoutAppearence = true;
        preserveLocalOverride = true;

        viewDocumentAfterExport = false;
    }
    document.exportFile(ExportFormat.HTML, outputFile);
}
else
{
    app.consoleout('Failed to open ' + documentToExport.fullName);
}

// close the document
document.close(SaveOptions.no);