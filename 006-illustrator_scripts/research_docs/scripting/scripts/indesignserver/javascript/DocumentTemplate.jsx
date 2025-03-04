//DocumentTemplate.jsx
//An InDesign Server JavaScript
//Creates a document template, including master pages, layers,
//a color, paragraph and character styles, guides, and XMP information.
//Make a new document.
var myDocument = app.documents.add();
//Set the document default measurement units to points.
myDocument.viewPreferences.horizontalMeasurementUnits = MeasurementUnits.points;
myDocument.viewPreferences.verticalMeasurementUnits = MeasurementUnits.points;
with(myDocument.marginPreferences){
	//Document baseline grid will be based on 14 points, and
	//all margins are set in increments of 14 points.
	top = 14 * 4;
	left = 14 * 4;
	bottom = 74;
	right = 14 * 5;
}
with(myDocument.documentPreferences){
	pageWidth = "7i";
	pageHeight = "9i";
	pageOrientation = PageOrientation.portrait;
	//Set up the bleed and slug areas.
	//Bleed
	documentBleedTopOffset = "3p";
	documentBleedUniformSize = true;
	//Slug
	slugBottomOffset = "18p";
	slugTopOffset = "3p";
	slugInsideOrLeftOffset = "3p";
	slugRightOrOutsideOffset = "3p";
}
//Create a color if it does not already exist.
try{
	myColor = myDocument.colors.item("PageNumberRed");
	myColor.name;
}
catch(myError){
	myColor = myDocument.colors.add();
	myColor.name = "PageNumberRed";
	myColor.model = ColorModel.process;
	myColor.colorValue = [20, 100, 80, 10];
}
//Next, set up some default styles.
//Create up a character style for the page numbers.
try{
	myCharacterStyle = myDocument.characterStyles.item("page_number");
	myCharacterStyle.name;
}
catch(myError){
	myCharacterStyle = myDocument.characterStyles.add();
	myCharacterStyle.name = "page_number";
}
myDocument.characterStyles.item("page_number").fillColor = myDocument.colors.item("PageNumberRed");
//Create up a pair of paragraph styles for the page footer text.
//These styles have only basic formatting.
try{
	myParagraphStyle = myDocument.paragraphStyles.item("footer_left");
	myParagraphStyle.name;
}
catch(myError){
	myParagraphStyle = myDocument.paragraphStyles.add();
	myParagraphStyle.name = "footer_left";
}
myParagraphStyle.pointSize = 11;
myParagraphStyle.leading = 14;
try{
	myParagraphStyle = myDocument.paragraphStyles.item("footer_right");
	myParagraphStyle.name;
}
catch(myError){
	myParagraphStyle = myDocument.paragraphStyles.add();
	myParagraphStyle.name = "footer_right";
}
myParagraphStyle.basedOn = myDocument.paragraphStyles.item("footer_left");
myParagraphStyle.justification = Justification.rightAlign;
myParagraphStyle.pointSize = 11;
myParagraphStyle.leading = 14;
//Create a layer for guides.
try{
	myLayer = myDocument.layers.item("GuideLayer");
	myLayer.name;
}
catch(myError){
	myLayer = myDocument.layers.add();
	myLayer.name = "GuideLayer";
}
//Create a layer for the footer items.
try{
	myLayer = myDocument.layers.item("Footer");
	myLayer.name;
}
catch(myError){
	myLayer = myDocument.layers.add();
	myLayer.name = "Footer";
}
//Create a layer for the slug items.
try{
	myLayer = myDocument.layers.item("Slug");
	myLayer.name;
}
catch(myError){
	myLayer = myDocument.layers.add();
	myLayer.name = "Slug";
}
//Create a layer for the body text.
try{
	myLayer = myDocument.layers.item("BodyText");
	myLayer.name;
}
catch(myError){
	myLayer = myDocument.layers.add();
	myLayer.name = "BodyText";
}
with(myDocument.viewPreferences){
	rulerOrigin = RulerOrigin.pageOrigin;
	horizontalMeasurementUnits = MeasurementUnits.points;
	verticalMeasurementUnits = MeasurementUnits.points;
}
//Document baseline grid and document grid
with(myDocument.gridPreferences){
	baselineStart = 56;
	baselineDivision = 14;
	baselineGridShown = false;
	horizontalGridlineDivision = 14;
	horizontalGridSubdivision = 5;
	verticalGridlineDivision = 14;
	verticalGridSubdivision = 5;
	documentGridShown = false;
}
//Document XMP information.
with(myDocument.metadataPreferences){
	author = "Olav Martin Kvern";
	copyrightInfoURL = "http://www.adobe.com";
	copyrightNotice = "This document is not copyrighted.";
	copyrightStatus = CopyrightStatus.no;
	description = "Example 7 x 9 book layout";
	documentTitle = "Example";
	jobName = "7 x 9 book layout template";
	keywords = ["7 x 9", "book", "template"];
	var myNewContainer = createContainerItem("http://ns.adobe.com/xap/1.0/", "email");
	setProperty("http://ns.adobe.com/xap/1.0/", "email/*[1]", "okvern@adobe.com");
}
//Set up the master spread.
with(myDocument.masterSpreads.item(0)){
	with(pages.item(0)){
		//Left and right are reversed for left-hand pages (becoming "inside" and "outside"--
		//this is also true in the InDesign user interface).
		myTopMargin = marginPreferences.top;
		myBottomMargin = myDocument.documentPreferences.pageHeight - marginPreferences.bottom;
		myRightMargin = myDocument.documentPreferences.pageWidth - marginPreferences.left;
		myLeftMargin = marginPreferences.right;
		with(guides.add()){
			itemLayer = myDocument.layers.item("GuideLayer");
			orientation = HorizontalOrVertical.vertical;
			location = myLeftMargin;
		}
		with(guides.add()){
			itemLayer = myDocument.layers.item("GuideLayer");
			orientation = HorizontalOrVertical.vertical;
			location = myRightMargin;
		}
		with(guides.add()){
			itemLayer = myDocument.layers.item("GuideLayer");
			orientation = HorizontalOrVertical.horizontal;
			location = myTopMargin;
			fitToPage = false;
		}
		with(guides.add()){
			itemLayer = myDocument.layers.item("GuideLayer");
			orientation = HorizontalOrVertical.horizontal;
			location = myBottomMargin;
			fitToPage = false;
		}
		with(guides.add()){
			itemLayer = myDocument.layers.item("GuideLayer");
			orientation = HorizontalOrVertical.horizontal;
			location = myBottomMargin + 14;
			fitToPage = false;
		}
		with(guides.add()){
			itemLayer = myDocument.layers.item("GuideLayer");
			orientation = HorizontalOrVertical.horizontal;
			location = myBottomMargin + 28;
			fitToPage = false;
		}
		var myLeftFooter = textFrames.add();
		myLeftFooter.move(undefined, [1, 1]);
		myLeftFooter.itemLayer = myDocument.layers.item("Footer");
		myLeftFooter.geometricBounds = [myBottomMargin + 14, marginPreferences.right, myBottomMargin + 28, myRightMargin];
		myLeftFooter.parentStory.insertionPoints.item(0).contents = SpecialCharacters.sectionMarker;
		myLeftFooter.parentStory.insertionPoints.item(0).contents = SpecialCharacters.emSpace;
		myLeftFooter.parentStory.insertionPoints.item(0).contents = SpecialCharacters.autoPageNumber;
		myLeftFooter.parentStory.characters.item(0).appliedCharacterStyle = myDocument.characterStyles.item("page_number");
		myLeftFooter.parentStory.paragraphs.item(0).applyParagraphStyle(myDocument.paragraphStyles.item("footer_left"), false);
		//Slug information.
		with(myDocument.metadataPreferences){
			var myString = "Author:\t" + author + "\tDescription:\t" + description + "\rCreation Date:\t" + new Date + 
			"\tEmail Contact\t" + getProperty("http://ns.adobe.com/xap/1.0/", "email/*[1]");
		}
		var myLeftSlug = textFrames.add();
		myLeftSlug.move(undefined, [1, 1]);
		myLeftSlug.itemLayer = myDocument.layers.item("Slug");
		myLeftSlug.geometricBounds = [myDocument.documentPreferences.pageHeight + 36, marginPreferences.right, myDocument.documentPreferences.pageHeight + 144, myRightMargin];
		myLeftSlug.contents = myString;
		myLeftSlug.parentStory.texts.item(0).convertToTable();
		//Body text master text frame.
		var myLeftFrame = textFrames.add();
		myLeftFrame.itemLayer = myDocument.layers.item("BodyText");
		myLeftFrame.geometricBounds = [marginPreferences.top, marginPreferences.right, myBottomMargin, myRightMargin];
	}
	with(pages.item(1)){
		myTopMargin = marginPreferences.top;
		myBottomMargin = myDocument.documentPreferences.pageHeight - marginPreferences.bottom;
		myRightMargin = myDocument.documentPreferences.pageWidth - marginPreferences.right;
		myLeftMargin = marginPreferences.left;
		with(guides.add()){
			itemLayer = myDocument.layers.item("GuideLayer");
			orientation = HorizontalOrVertical.vertical;
			location = myLeftMargin;
		}
		with(guides.add()){
			itemLayer = myDocument.layers.item("GuideLayer");
			orientation = HorizontalOrVertical.vertical;
			location = myRightMargin;
		}
		var myRightFooter = textFrames.add();
		myRightFooter.move(undefined, [1, 1]);
		myRightFooter.itemLayer = myDocument.layers.item("Footer");
		myRightFooter.geometricBounds = [myBottomMargin + 14, marginPreferences.left, myBottomMargin + 28, myRightMargin];
		myRightFooter.parentStory.insertionPoints.item(0).contents = SpecialCharacters.autoPageNumber;
		myRightFooter.parentStory.insertionPoints.item(0).contents = SpecialCharacters.emSpace;
		myRightFooter.parentStory.insertionPoints.item(0).contents = SpecialCharacters.sectionMarker;
		myRightFooter.parentStory.characters.item(-1).appliedCharacterStyle = myDocument.characterStyles.item("page_number");
		myRightFooter.parentStory.paragraphs.item(0).applyParagraphStyle(myDocument.paragraphStyles.item("footer_right"), false);
		//Slug information.
		var myRightSlug = textFrames.add();
		myRightSlug.move(undefined, [1, 1]);
		myRightSlug.itemLayer = myDocument.layers.item("Slug");
		myRightSlug.geometricBounds = [myDocument.documentPreferences.pageHeight + 36, myLeftMargin, myDocument.documentPreferences.pageHeight + 144, myRightMargin];
		myRightSlug.contents = myString;
		myRightSlug.parentStory.texts.item(0).convertToTable();
		//Body text master text frame.
		var myRightFrame = textFrames.add();
		myRightFrame.itemLayer = myDocument.layers.item("BodyText");
		myRightFrame.geometricBounds = [marginPreferences.top, marginPreferences.left, myBottomMargin, myRightMargin]
		myRightFrame.previousTextFrame = myLeftFrame;
	}
}
//Add section marker text--this text will appear in the footer.
myDocument.sections.item(0).marker = "Section 1";

//Save the file (fill in a valid file path on your system).
var myFile = new File("/c/ServerTestFiles/myTestDocument.indd");
var result = "saved to:  " + myFile.fullName;
if(!myFile.parent.exists && !myFile.parent.create()) {
	result = "Not saved.  Unable to create the folder:  " + myFile.parent.fullName;
} else {
	myDocument = myDocument.save(myFile);
}
//Close the document
myDocument.close();

result;