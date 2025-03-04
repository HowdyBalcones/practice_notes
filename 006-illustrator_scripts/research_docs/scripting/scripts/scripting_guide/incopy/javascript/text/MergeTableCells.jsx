//MergeTableCells.jsx
//An InCopy JavaScript
//
//Shows how to merge cells in a table.
main();
function main(){
	mySetup();
	mySnippet();
	myTeardown();
}
function mySetup(){
}
function mySnippet(){
	//<fragment>
	var myDocument = app.documents.add();
	var myStory = myDocument.stories.item(0);
	var myString = "Table\r";
	myStory.contents = myString;
	var myTable = myStory.insertionPoints.item(-1).tables.add();
	myTable.columnCount = 4;
	myTable.bodyRowCount = 4;
	//Merge all of the cells in the first column.
	myTable.cells.item(0).merge(myTable.columns.item(0).cells.item(-1));
	//Convert column 2 into 2 cells (rather than 4).
	myTable.columns.item(1).cells.item(-1).merge(myTable.columns.item(1).cells.item(-2));
	myTable.columns.item(1).cells.item(0).merge(myTable.columns.item(1).cells.item(1));
	//Merge the last two cells in row 1.
	myTable.rows.item(0).cells.item(-2).merge(myTable.rows.item(0).cells.item(-1));
	//Merge the last two cells in row 3.
	myTable.rows.item(2).cells.item(-2).merge(myTable.rows.item(2).cells.item(-1));
	//</fragment>
}
function myTeardown(){
}
