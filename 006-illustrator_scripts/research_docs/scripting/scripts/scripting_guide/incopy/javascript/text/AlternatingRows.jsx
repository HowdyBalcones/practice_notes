//AlternatingRows.jsx
//An InCopy JavaScript
//
//Shows how to format table rows using alternating rows.
main();
function main(){
	mySetup();
	mySnippet();
	myTeardown();
}
function mySetup(){
	var myDocument = app.documents.add();
	//Add colors.
	myAddColor(myDocument, "DGC1_446a", ColorModel.process, [0, 100, 0, 50]);
	myAddColor(myDocument, "DGC1_446b", ColorModel.process, [100, 0, 50, 0]);
	var myStory = myDocument.stories.item(0);
	var myString = "Head 1\tHead 2\tHead 3\r1a\t1b\t1c\r2a\t2b\t2c\r3a\t3b\t3c\r4a\t4b\t4c\r5a\t5b\t5c";
	myStory.contents = myString;
	myStory.texts.item(0).convertToTable();
	return myDocument;
}
function mySnippet(){
	var myDocument = app.documents.item(0);
	var myTable = myDocument.stories.item(0).tables.item(0);
	//Convert the first row to a header row.
	myTable.rows.item(0).rowType = RowTypes.headerRow;
	//Applly alternating fills to the table.
	myTable.alternatingFills = AlternatingFillsTypes.alternatingRows;
	myTable.startRowFillColor = myDocument.swatches.item("DGC1_446a");
	myTable.startRowFillTint = 60;
	myTable.endRowFillColor = myDocument.swatches.item("DGC1_446b");
	myTable.endRowFillTint = 50;
}
function myTeardown(){
}
function myAddColor(myDocument, myColorName, myColorModel, myColorValue){
	try{
		myColor = myDocument.colors.item(myColorName);
		myName = myColor.name;
	}
	catch (myError){
		myColor = myDocument.colors.add();
	}
	myColor.properties = {name:myColorName, model:myColorModel, colorValue:myColorValue};
}