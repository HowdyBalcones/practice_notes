//==============================================================================
// Export as XHTML for Digital Editions sample script.
//==============================================================================

// Usage:
//
// This script will export a document or book as an XHTML based ePub document
// viewable in Adobe Digital Editions. Change the name and location of the source
// and destination below.

//------------------------------------------------------------------------------
// Preparation
//------------------------------------------------------------------------------
function digitalEditionsExport() {
    // replace this with the paths of your files
    var outputFile = new File("/c/ServerTestFiles/myTest.epub");
    var documentOrBookToExport = new File("/c/ServerTestFiles/myTestDocument.indd");

    var success = false;

    if (documentOrBookToExport.exists) {
        // open the document or book... the export engine can take either.		
        var source = app.open(documentOrBookToExport, OpenOptions.OPEN_ORIGINAL, false);

        app.consoleout("source name = " + source.fullName);

        with (source.epubExportPreferences)
        {
            //Apply image alignment to anchored object settings.
            applyImageAlignmentToAnchoredObjectSettings = false;

            //The unit of space.
            spaceUnit = SpaceUnitType.CSS_EM;
            //The unit of margin.
            marginUnit = SpaceUnitType.CSS_EM;

            //Bottom margin of the epub.
            bottomMargin = 5;
            //Left margin of the epub.
            leftMargin = 5;
            //Right margin of the epub.
            rightMargin = 5;
            //Top margin of the epub.
            topMargin = 5;

            //If true, break InDesign document into smaller pieces when generating epub.
            breakDocument = false;
            //The name of paragraph style to break InDesign document.
            //paragraphStyleName = "";

            //The bullet export option.
            bulletExportOption = BulletListExportOption.AS_TEXT;

            cssExportOption = StyleSheetExportOption.EMBEDDED_CSS;
            customImageSizeOption = ImageSizeOption.SIZE_RELATIVE_TO_PAGE_WIDTH;

            embedFont = true;
            epubCover = EpubCover.FIRST_PAGE;
            //This will take effect only when epubCover is set to EXTERNAL_IMAGE.			
            //coverImageFile = "/c/ServerTestFiles/cover.jpg"

            epubPublisher = "Adobe Devtech";

            //The export order.
            exportorder = ExportOrder.LAYOUT_ORDER;

            //If true, output footnote immediately after its paragraph.
            footnoteFollowParagraph = false;

            //If true, export epub in XHTML format. Otherwise, in DTBook format.
            format = true;

            gifOptionsInterlaced = true;
            gifOptionsPalette = GIFOptionsPalette.WINDOWS_PALETTE;

            //The epub unique identifier, like ISBN.
            id = "123";

            //Ignore object level image conversion settings.
            ignoreObjectConversionSettings = true;

            //Alignment applied to images.
            imageAlignment = ImageAlignmentType.ALIGN_CENTER;
            //The file format to use for converted images.
            //Valid only when copy optimized images and/or copy formatted images is true.
            imageConversion = ImageConversion.AUTOMATIC;
            imageExportResolution = ImageResolution.PPI_150;
            //Image page break settings to be used with objects.
            imagePageBreak = ImagePageBreakType.PAGE_BREAK_AFTER;
            //Space After applied to images.
            imageSpaceAfter = 2;
            //Space Before applied to images.
            imageSpaceBefore = 2;

            //If true, include CSS definition.
            includeCSSDefinition = true;
            //If true, output document metadata into epub.
            includeDocumentMetadata = true;

            jpegOptionsFormat = JPEGOptionsFormat.BASELINE_ENCODING;
            jpegOptionsQuality = JPEGOptionsQuality.HIGH;

            //The PNG compression level.
            level = 5;

            numberedListExportOption = NumberedListExportOption.AS_TEXT;	

            //If true, format image based on layout appearence.
            preserveLayoutAppearence = true;
            //If true, output local style override.
            preserveLocalOverride = true;

            stripSoftReturn = true;	
            //If true, image page break settings will be used in objects.
            useImagePageBreak = true;
            //Use InDesign TOC style to generate epub TOC.
            useTocStyle = true;

            viewDocumentAfterExport = false;
        }
        source.exportFile(ExportFormat.EPUB, outputFile);
        success = true;

        // close the document
        source.close(SaveOptions.no);
    } // if (documentOrBookToExport.exists)
    else
    {
        app.consoleout('Failed to open ' + documentOrBookToExport.fullName);
    }
    return success;
}

var result = digitalEditionsExport();
var message = "Digital Editions Export ";
message += result?"did ":"did not ";
message += "export the file.";
message;