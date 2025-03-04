//ExportPDFWithOptions.jsx
//An InDesign Server JavaScript
//Sets PDF export options, then exports the current document as PDF.
var result = "No documents are open.";
if(app.documents.length > 0){
	result = "success";
	with(app.pdfExportPreferences){
		//Basic PDF output options.
		pageRange = PageRange.allPages;
		acrobatCompatibility = AcrobatCompatibility.acrobat6;
		exportGuidesAndGrids = false;
		exportLayers = false;
		exportNonPrintingObjects = false;
		exportReaderSpreads = false;
		generateThumbnails = false;
		try{
			ignoreSpreadOverrides = false;
		}
		catch(e){}
		includeBookmarks = true;
		includeHyperlinks = true;
		includeICCProfiles = true;
		includeSlugWithPDF = false;
		includeStructure = false;
		interactiveElements = false;
		//Setting subsetFontsBelow to zero disallows font subsetting;
		//set subsetFontsBelow to some other value to use font subsetting.
		subsetFontsBelow = 0;
		//
		//Bitmap compression/sampling/quality options.
		colorBitmapCompression = BitmapCompression.zip;
		colorBitmapQuality = CompressionQuality.eightBit;
		colorBitmapSampling = Sampling.none;
		//thresholdToCompressColor is not needed in this example.
		//colorBitmapSamplingDPI is not needed when colorBitmapSampling is set to none.
		grayscaleBitmapCompression = BitmapCompression.zip;
		grayscaleBitmapQuality = CompressionQuality.eightBit;
		grayscaleBitmapSampling = Sampling.none;
		//thresholdToCompressGray is not needed in this example.
		//grayscaleBitmapSamplingDPI is not needed when grayscaleBitmapSampling is set to none.
		monochromeBitmapCompression = BitmapCompression.zip;
		monochromeBitmapSampling = Sampling.none;
		//thresholdToCompressMonochrome is not needed in this example.
		//monochromeBitmapSamplingDPI is not needed when monochromeBitmapSampling is set to none.
		//
		//Other compression options.
		compressionType = PDFCompressionType.compressNone;
		compressTextAndLineArt = true;
		cropImagesToFrames = true;
		optimizePDF = true;
		//
		//Printers marks and prepress options.
		//Get the bleed amounts from the document's bleed.
		bleedBottom = app.documents.item(0).documentPreferences.documentBleedBottomOffset;
		bleedTop = app.documents.item(0).documentPreferences.documentBleedTopOffset;
		bleedInside = app.documents.item(0).documentPreferences.documentBleedInsideOrLeftOffset;
		bleedOutside = app.documents.item(0).documentPreferences.documentBleedOutsideOrRightOffset;
		//If any bleed area is greater than zero, then export the bleed marks.
		if(bleedBottom == 0 && bleedTop == 0 && bleedInside == 0 && bleedOutside == 0){
			bleedMarks = true;
		}
		else{
			bleedMarks = false;
		}
		colorBars = true;
		colorTileSize = 128;
		grayTileSize = 128;
		cropMarks = true;
		omitBitmaps = false;
		omitEPS = false;
		omitPDF = false;
		pageInformationMarks = true;
		pageMarksOffset = "12pt";
		pdfColorSpace = PDFColorSpace.unchangedColorSpace;
		//Default mark type.
		pdfMarkType = 1147563124;
		printerMarkWeight = PDFMarkWeight.p125pt;
		registrationMarks = true;
		try{
			simulateOverprint = false;
		}
		catch(e){}
		useDocumentBleedWithPDF = true;
		//Set viewPDF to true to open the PDF in Acrobat or Adobe Reader.
		viewPDF = false;
	}
	//Now export the document. You'll have to fill in your own file path.
	var myFile = new File("/c/ServerTestFiles/myTestDocument.pdf");
	var result = "exported to:  " + myFile.fullName;
	if(!myFile.parent.exists && !myFile.parent.create()) {
		result = "Not exported.  Unable to create the folder:  " + myFile.parent.fullName;
	} else {
		app.documents.item(0).exportFile(ExportFormat.pdfType, myFile);
	}
}

result;