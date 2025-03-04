//ApplicationTextDefaults.jsx
//An InDesign Server JavaScript
//Sets the application text defaults, which will become the text formatting
//defaults for all new documents. Existing documents will remain unchanged.
with(app.textDefaults){
	//The following settings have a chance of generating
	//errors when the specific fonts, font styles, and/or
	//languages are not installed on your system. Use try..catch
	//to skip any errors.
	try{
		appliedFont = app.fonts.item("Minion Pro");
		fontStyle = "Regular";
		appliedLanguage = "English: USA";
	}catch(myError){}
	autoLeading = 100;
	balanceRaggedLines = false;
	baselineShift = 0;
	capitalization = Capitalization.normal;
	composer = "Adobe Paragraph Composer";
	desiredGlyphScaling = 100;
	desiredLetterSpacing = 0;
	desiredWordSpacing = 100;
	dropCapCharacters = 0;
	//If dropCapCharacters = 0, then trying to set the dropCapLines
	//property will generate an error.
	if(dropCapCharacters != 0){
		dropCapLines = 3;
		//Assumes that the application has a default
		//character style named "myDropCap"
		dropCapStyle = app.characterStyles.item("myDropCap");
	}
	fillColor = app.colors.item("Black");
	fillTint = 100;
	firstLineIndent = "14pt";
	gridAlignFirstLineOnly = false;
	horizontalScale = 100;
	hyphenateAfterFirst = 3;
	hyphenateBeforeLast = 4;
	hyphenateCapitalizedWords = false;
	hyphenateLadderLimit = 1;
	hyphenateWordsLongerThan = 5;
	hyphenation = true;
	hyphenationZone = "3p";
	hyphenWeight = 9;
	justification = Justification.leftAlign;
	keepAllLinesTogether = false;
	keepLinesTogether = true;
	keepFirstLines = 2;
	keepLastLines = 2;
	keepWithNext = 0;
	kerningMethod = "Optical";
	leading = 14;
	leftIndent = 0;
	ligatures = true;
	maximumGlyphScaling = 100;
	maximumLetterSpacing = 0;
	maximumWordSpacing = 160;
	minimumGlyphScaling = 100;
	minimumLetterSpacing = 0;
	minimumWordSpacing = 80;
	noBreak = false;
	otfContextualAlternate = true;
	otfDiscretionaryLigature = true;
	otfFigureStyle = OTFFigureStyle.proportionalOldstyle;
	otfFraction = true;
	otfHistorical = true;
	otfOrdinal = false;
	otfSlashedZero = true;
	otfSwash = false;
	otfTitling = false;
	overprintFill = false;
	overprintStroke = false;
	pointSize = 11;
	position = Position.normal;
	rightIndent = 0;
	//If ruleAbove is false, attempting to set some of the
	//rule above properties will generate an error. Though
	//we’ve set ruleAbove to false, we’ve included the properties
	//to provide a more complete example.
	ruleAbove = false;
	if(ruleAbove == true){
		ruleAboveColor = app.colors.item("Black");
		ruleAboveGapColor = app.swatches.item("None");
		ruleAboveGapOverprint = false;
		ruleAboveGapTint = 100;
		ruleAboveLeftIndent = 0;
		ruleAboveLineWeight = 0.25;
		ruleAboveOffset = 14;
		ruleAboveOverprint = false;
		ruleAboveRightIndent = 0;
		ruleAboveTint = 100;
		ruleAboveType = app.strokeStyles.item("Solid");
		ruleAboveWidth = RuleWidth.columnWidth;
	}
	//If ruleBelow is false, attempting to set some of the
	//rule below properties will generate an error. Though
	//we’ve set ruleBelow to false, we’ve included the properties
	//to provide a more complete example.
	ruleBelow = false;
	if(ruleBelow == true){
		ruleBelowColor = app.colors.item("Black");
		ruleBelowGapColor = app.swatches.item("None");
		ruleBelowGapOverPrint = false;
		ruleBelowGapTint = 100;
		ruleBelowLeftIndent = 0;
		ruleBelowLineWeight = 0.25;
		ruleBelowOffset = 0;
		ruleBelowOverPrint = false;
		ruleBelowRightIndent = 0;
		ruleBelowTint = 100;
		ruleBelowType = app.strokeStyles.item("Solid");
		ruleBelowWidth = RuleWidth.columnWidth;
	}
	singleWordJustification = SingleWordJustification.leftAlign;
	skew = 0;
	spaceAfter = 0;
	spaceBefore = 0;
	startParagraph = StartParagraph.anywhere;
	//If strikeThru is false, attempting to set some of the
	//strikethrough properties will generate an error. Though
	//we’ve set strikeThru to false, we’ve included the properties
	//to provide a more complete example.
	strikeThru = false;
	if(strikeThru == true){
		strikeThroughColor = app.colors.item("Black");
		strikeThroughGapColor = app.swatches.item("None");
		strikeThroughGapOverprint = false;
		strikeThroughGapTint = 100;
		strikeThroughOffset = 3;
		strikeThroughOverprint = false;
		strikeThroughTint = 100;
		strikeThroughType = app.strokeStyles.item("Solid");
		strikeThroughWeight = 0.25;
	}
	strokeColor = app.swatches.item("None");
	strokeTint = 100;
	strokeWeight = 0;
	tracking = 0;
	//If underline is false, attempting to set some of the
	//underline properties will generate an error. Though
	//we’ve set underline to false, we’ve included the properties
	//to provide a more complete example.
	underline = false;
	if(underline == true){
		underlineColor = app.colors.item("Black");
		underlineGapColor = app.swatches.item("None");
		underlineGapOverprint = false;
		underlineGapTint = 100;
		underlineOffset = 3;
		underlineOverprint = false;
		underlineTint = 100;
		underlineType = app.strokeStyles.item("Solid");
		underlineWeight = 0.25;
	}
	verticalScale = 100;
}