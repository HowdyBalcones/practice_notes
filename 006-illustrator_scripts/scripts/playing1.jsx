// Testing export methods
// Looks like we can use templates are declare settings 
// during an export

// export each page as PDF from inDesign
// given preset list to the entire export

// WORKING IDEAS
// - contains profiles for every needed export preset 
// - checks the name of the file and exports based on keyword
// - can add keywords in name to export with multiple presets 
// - can rename based on the keyword used, just adds a suffix

(function () {
    try {
    var doc = app.activeDocument;
    var docPath = doc.filePath.absoluteURI;
    var exportPath = 'C:\\Users\\graphics2\\Desktop\\009-Export_Ingest\\test.pdf'
    // make a new file and initialize
    var pdfTest1 = new File(exportPath);
    // this is how to access the pdf-export-preferences properties

    // these are pdf-presets, templates that you can set with the UI
    // var pdfPresets = app.pdfExportPresets.itemByName('Fource_Export-1');
    var pdfPresets2 = app.pdfExportPresets.itemByName('Fource_Export-2');
    var pdfPresets3 = app.pdfExportPresets.itemByName('[PDF/X-3:2002]');
    
    var pdfExportOptions = app.pdfExportPreferences;
    // functional preferences
    pdfExportOptions.bleedBottom = 0.125;
    pdfExportOptions.bleedTop = 0.125;
    pdfExportOptions.bleedInside = 0.125;
    pdfExportOptions.bleedOutside = 0.125;
    pdfExportOptions.bleedMarks = true;
    pdfExportOptions.cropMarks = true;
    pdfExportOptions.pageRange = "1-5"; 
    pdfExportOptions.includeHyperlinks = true;
   //  pdfExportOptions.exportReaderSpreads = true;
    pdfExportOptions.colorBars = true;
   // pdfExportOptions.exportAsSinglePages = true;
    pdfExportOptions.exportLayers = true;
    pdfExportOptions.pdfPageLayout = PageLayoutOptions.TWO_UP_FACING;


    
    // FAILURES
    // pdfExportOptions.compression = PDFCompressionType.COMPRESS_JPEG2000;
    // pdfExportOptions.JPEGQuality = PDFJPEGQualityOptions.HIGH;
    // pdfExportOptions.colorConversion = ColorConversionOptions.CONVERT_TO_DEST;
    // pdfExportOptions.destinationProfile = app.colorSettings.cmykProfile;
     
     
     // preferences set inside a script will be overriden by a preset template


    
    // This is the exporting method 
    // could create fall back, but won't work with a preset if options are set
    doc.exportFile(ExportFormat.PDF_TYPE, pdfTest1, false);
    // below is an alternate method for export where the file 
    // gets made in the export method
    // doc.exportFile(ExportFormat.PDF_TYPE, File(exportPath), false, pdfPresets); 
    
    // Lets you know the export is complete
    alert('Export Complete at:' + exportPath );
    } catch(e) {
    alert('Following Error: ' + e);
    }    
})();