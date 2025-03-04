//ApplyStylesToXMLElements.jsx
//An InCopy JavaScript
//
//Shows how to apply paragraph and character styles to XML elements
//without using a tag to style/style to tag mapping.
main();
function main(){
	mySetup();
	mySnippet();
	myTeardown();
}
function mySetup(){
	var myDocument = app.documents.add();
	myDocument.viewPreferences.horizontalMeasurementUnits = MeasurementUnits.points;
	myDocument.viewPreferences.verticalMeasurementUnits = MeasurementUnits.points;
	//Create a series of paragraph styles.
	var myHeading1Style = myDocument.paragraphStyles.add();
	myHeading1Style.name = "heading 1";
	myHeading1Style.pointSize = 24;
	var myHeading2Style = myDocument.paragraphStyles.add();
	myHeading2Style.name = "heading 2";
	myHeading2Style.pointSize = 14;
	myHeading2Style.spaceBefore = 12;
	var myPara1Style = myDocument.paragraphStyles.add();
	myPara1Style.name = "para 1";
	myPara1Style.pointSize = 12;
	myPara1Style.firstLineIndent = 0;
	var myBodyTextStyle = myDocument.paragraphStyles.add();
	myBodyTextStyle.name = "body text";
	myBodyTextStyle.pointSize = 12;
	myBodyTextStyle.firstLineIndent = 24;
	//Create a character style.
	var myCharacterStyle = myDocument.characterStyles.add();
	myCharacterStyle.name = "Emphasis";
	myCharacterStyle.fontStyle = "Italic";
}
function mySnippet(){
	var myDocument = app.documents.item(0);
	//Create a series of XML tags.
	var myHeading1XMLTag = myDocument.xmlTags.add("heading_1");
	var myHeading2XMLTag = myDocument.xmlTags.add("heading_2");
	var myPara1XMLTag = myDocument.xmlTags.add("para_1");
	var myBodyTextXMLTag = myDocument.xmlTags.add("body_text");
	//Add XML elements and apply paragraph styles.
	var myRootXMLElement = myDocument.xmlElements.item(0);
	var myXMLElementA = myRootXMLElement.xmlElements.add(myHeading1XMLTag);
	myXMLElementA.contents = "Heading 1";
	myXMLElementA.insertTextAsContent("\r", XMLElementPosition.afterElement);
	myXMLElementA.applyParagraphStyle(myDocument.paragraphStyles.item("heading 1"), true);
	var myXMLElementB = myRootXMLElement.xmlElements.add(myPara1XMLTag);
	myXMLElementB.contents = "This is the first paragraph in the article.";
	myXMLElementB.insertTextAsContent("\r", XMLElementPosition.afterElement);
	myXMLElementB.applyParagraphStyle(myDocument.paragraphStyles.item("para 1"), true);
	var myXMLElementC = myRootXMLElement.xmlElements.add(myBodyTextXMLTag);
	myXMLElementC.contents = "This is the second paragraph in the article.";
	myXMLElementC.insertTextAsContent("\r", XMLElementPosition.afterElement);
	myXMLElementC.applyParagraphStyle(myDocument.paragraphStyles.item("body text"), true);
	var myXMLElementD = myRootXMLElement.xmlElements.add(myHeading2XMLTag);
	myXMLElementD.contents = "Heading 2";
	myXMLElementD.insertTextAsContent("\r", XMLElementPosition.afterElement);
	myXMLElementD.applyParagraphStyle(myDocument.paragraphStyles.item("heading 2"), true);
	var myXMLElementE = myRootXMLElement.xmlElements.add(myPara1XMLTag);
	myXMLElementE.contents = "This is the first paragraph following the subhead.";
	myXMLElementE.insertTextAsContent("\r", XMLElementPosition.afterElement);
	myXMLElementE.applyParagraphStyle(myDocument.paragraphStyles.item("para 1"), true);
	var myXMLElementF = myRootXMLElement.xmlElements.add(myBodyTextXMLTag);
	myXMLElementF.contents = "Note:";
	myXMLElementF.applyCharacterStyle(myDocument.characterStyles.item("Emphasis"), true);
	myXMLElementF.insertTextAsContent(" ", XMLElementPosition.afterElement);
	var myXMLElementG = myRootXMLElement.xmlElements.add(myBodyTextXMLTag);
	myXMLElementG.contents = "This is the second paragraph following the subhead.";
	myXMLElementG.insertTextAsContent("\r", XMLElementPosition.afterElement);
	myXMLElementG.applyParagraphStyle(myDocument.paragraphStyles.item("body text"), true);
	// Associate the root XML element with the story.
	myDocument.stories.item(0).placeXML(myRootXMLElement);
}
function myTeardown(){
}