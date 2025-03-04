//PrintPreferences.jsx
//An InDesign Server JavaScript
//Sets the print preferences of the current document.
//The comments in this section refer to various panels of the InDesign Print dialog box.
var result = "No documents are open.";
if(app.documents.length > 0) {
	with(app.documents.item(0).printPreferences){
		//Properties corresponding to the controls in the General panel 
		//of the Print dialog box. activePrinterPreset is ignored in this 
		//example--we'll set our own print preferences. printer can be 
		//either a string (the name of the printer) or Printer.postscriptFile.
		printer = "Adobe PDF";
		//If the printer property is the name of a printer, then the ppd property
		//is locked (and will return an error if you try to set it).
		//ppd = "AGFA-SelectSet5000SF";
		//If the printer property is set to Printer.postscript file, the copies
		//property is unavailable. Attempting to set it will generate an error.
		copies = 1;
		//If the printer property is set to Printer.postscript file, or if the
		//selected printer does not support collation, then the collating 
		//property is unavailable. Attempting to set it will generate an error.
		//collating = false;
		reverseOrder = false;
		//pageRange can be either PageRange.allPages or a page range string.
		pageRange = PageRange.allPages;
		printSpreads = false;
		printMasterPages = false;
		//If the printer property is set to Printer.postScript file, then
		//the printFile property contains the file path to the output file.
		//printFile = "/c/test.ps";
		sequence = Sequences.all;
		//--------------------------------------------------------------------------------
		//Properties corresponding to the controls in the Output panel of the Print dialog box.
		//--------------------------------------------------------------------------------
		colorOutput = ColorOutputModes.separations;
		negative = true;
		//Note the lowercase "i" in "Builtin"
		trapping = Trapping.applicationBuiltin;
		screening = "175 lpi/2400 dpi";
		flip = Flip.none;
		//If trapping is on, attempting to set the following properties will generate an error.
		if(trapping == Trapping.off){
			printBlack = true;
			printCyan = true;
			printMagenta = true;
			printYellow = true;
		}
		//Only change the ink angle and frequency when you want to override the
		//screening set by the screening specified by the screening property.
		//blackAngle = 45;
		//blackFrequency = 175;
		//cyanAngle = 15;
		//cyanFrequency = 175;
		//magentaAngle = 75;
		//magentaFreqency = 175;
		//yellowAngle = 0;
		//yellowFrequency = 175;
		//The following properties are not needed (because colorOutput is set to separations).
		//compositeAngle = 45;
		//compositeFrequency = 175;
		//simulateOverprint = false;
		//If trapping is on, setting the following properties will produce an error.
			if(trapping == Trapping.off){
			printBlankPages = false;
			printGuidesGrids = false;
			printNonprinting = false;
		}
		//--------------------------------------------------------------------------------
		//Properties corresponding to the controls in the Setup panel of the Print dialog box.
		//--------------------------------------------------------------------------------
		paperSize = PaperSizes.custom;
		//Page width and height are ignored if paperSize is not PaperSizes.custom.
		//paperHeight = 1200;
		//paperWidth = 1200;
		printPageOrientation = PrintPageOrientation.portrait;
		pagePosition = PagePositions.centered;
		paperGap = 0;
		paperOffset = 0;
		paperTransverse = false;
		scaleHeight = 100;
		scaleWidth = 100;
		scaleMode = ScaleModes.scaleWidthHeight;
		scaleProportional = true;
		//If trapping is on, attempting to set the following properties will produce an error.
		if(trapping == Trapping.off){
			textAsBlack = false;
			thumbnails = false;
			//The following properties is not needed because thumbnails is set to false.
			//thumbnailsPerPage = 4;
			tile = false;
			//The following properties are not needed because tile is set to false.
			//tilingOverlap = 12;
			//tilingType = TilingTypes.auto;
		}


		//--------------------------------------------------------------------------------
		//Properties corresponding to the controls in the Marks and Bleed panel of the Print dialog box.
		//--------------------------------------------------------------------------------
		//Set the following property to true to print all printer's marks.
		//allPrinterMarks = true;
		useDocumentBleedToPrint = false;
		//If useDocumentBleedToPrint = false then setting any of the  bleed properties
		//will result in an error.
		//Get the bleed amounts from the document's bleed and add a bit.
		bleedBottom = app.documents.item(0).documentPreferences.documentBleedBottomOffset+3;
		bleedTop = app.documents.item(0).documentPreferences.documentBleedTopOffset+3;
		bleedInside = app.documents.item(0).documentPreferences.documentBleedInsideOrLeftOffset+3;
		bleedOutside = app.documents.item(0).documentPreferences.documentBleedOutsideOrRightOffset+3;
		//If any bleed area is greater than zero, then export the bleed marks.
		if(bleedBottom == 0 && bleedTop == 0 && bleedInside == 0 && bleedOutside == 0){
			bleedMarks = true;
		}
		else{
			bleedMarks = false;
		}
		colorBars = true;
		cropMarks = true;
		includeSlugToPrint = false;
		markLineWeight = MarkLineWeight.p125pt
		markOffset = 6;
		//markType = MarkTypes.default;
		pageInformationMarks = true;
		registrationMarks = true;


		//--------------------------------------------------------------------------------
		//Properties corresponding to the controls in the Graphics panel of the Print dialog box.
		//--------------------------------------------------------------------------------
		sendImageData = ImageDataTypes.allImageData;
		fontDownloading = FontDownloading.complete;
		downloadPPDFOnts = true;
		try{
			dataFormat = DataFormat.binary;
		}
		catch(e){}
		try{
			postScriptLevel = PostScriptLevels.level3;
		}
		catch(e){}

		//--------------------------------------------------------------------------------
		//Properties corresponding to the controls in the Color Management panel of the Print dialog box.
		//--------------------------------------------------------------------------------
		//If the useColorManagement property of app.colorSettings is false,
		//attempting to set the following properties will return an error.
		try{
			sourceSpace = SourceSpaces.useDocument;
			intent = RenderingIntent.useColorSettings;
			crd = ColorRenderingDictionary.useDocument;
			profile = Profile.postscriptCMS;
		}
		catch(e){}

		//--------------------------------------------------------------------------------
		//Properties corresponding to the controls in the Advanced panel of the Print dialog box.
		//--------------------------------------------------------------------------------
		opiImageReplacement = false;
		omitBitmaps = false;
		omitEPS = false;
		omitPDF = false;
		//The following line assumes that you have a flattener preset named "high quality flattener".
		try{
			flattenerPresetName = "high quality flattener";
		}
		catch(e){}
		ignoreSpreadOverrides = false;
	}
	result = "success";
}

result;