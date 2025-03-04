//ApplyTableStyle.jsx
//An InCopy JavaScript
//
//Shows how to convert a series of XML elements to a table
//using the ConvertTextToTableByTag method and apply a style
//to them.
main();
function main(){
    mySetup();
    mySnippet();
    myTeardown();
}
function mySetup(){
}
function mySnippet(){
	var myDocument = app.documents.add();
	//Create a series of XML tags.
	var myRowTag = myDocument.xmlTags.add("row");
	var myCellTag = myDocument.xmlTags.add("cell");
	var myTableTag = myDocument.xmlTags.add("table");
	//Create a table style and a cell style.
	var myTableStyle = myDocument.tableStyles.add({name:"myTableStyle"});
	myTableStyle.startRowFillColor = myDocument.colors.item("Black");
	myTableStyle.startRowFillTint = 25;
	myTableStyle.endRowFillColor = myDocument.colors.item("Black");
	myTableStyle.endRowFillTint = 10;
	var myCellStyle = myDocument.cellStyles.add();
	myCellStyle.fillColor = myDocument.colors.item("Black");
	myCellStyle.fillTint = 45
	//Add XML elements.
	var myRootXMLElement = myDocument.xmlElements.item(0);
	with(myRootXMLElement){
		var myTableXMLElement = xmlElements.add(myTableTag);
		with(myTableXMLElement){
			for(var myRowCounter = 1;myRowCounter < 7;myRowCounter++){
				with(xmlElements.add(myRowTag)){
					myString = "Row " + myRowCounter;
					for(var myCellCounter = 1; myCellCounter < 5; myCellCounter++){
						with(xmlElements.add(myCellTag)){
							contents = myString + ":Cell " + myCellCounter;
						}
					}
				}
			}
		}
	}
	var myTable = myTableXMLElement.convertElementToTable(myRowTag, myCellTag);
	var myTableXMLElement = myDocument.xmlElements.item(0).xmlElements.item(0);
	myTableXMLElement.applyTableStyle(myTableStyle);
	myTableXMLElement.xmlElements.item(0).applyCellStyle(myCellStyle);
	myTableXMLElement.xmlElements.item(5).applyCellStyle(myCellStyle);
	myTableXMLElement.xmlElements.item(10).applyCellStyle(myCellStyle);
	myTableXMLElement.xmlElements.item(15).applyCellStyle(myCellStyle);
	myTableXMLElement.xmlElements.item(16).applyCellStyle(myCellStyle);
	myTableXMLElement.xmlElements.item(21).applyCellStyle(myCellStyle);
	myDocument.stories.item(0).placeXML(myDocument.xmlElements.item(0));
	myTable.alternatingFills = AlternatingFillsTypes.alternatingRows;
}
function myTeardown(){
}