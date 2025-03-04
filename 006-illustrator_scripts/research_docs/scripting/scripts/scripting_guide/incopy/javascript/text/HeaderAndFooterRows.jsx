//HeaderAndFooterRows.jsx
//An InCopy JavaScript
//
//Shows how to add header and footer rows to a table.
main();
function main(){
	mySetup();
	mySnippet();
	myTeardown();
}
function mySetup(){
	//Create an example document.
	var myDocument = app.documents.add();
	var myStory = myDocument.stories.item(0);
	var myString = "Head 1\tHead 2\tHead 3\r1a\t1b\t1c\r2a\t2b\t2c\r3a\t3b\t3c\rFoot 1\tFoot 2\tFoot 3";
	myStory.contents = myString;
	myStory.texts.item(0).convertToTable();
}
function mySnippet(){
	//<fragment>
	var myTable = app.documents.item(0).stories.item(0).tables.item(0);
	//Convert the first row to a header row.
	myTable.rows.item(0).rowType = RowTypes.headerRow;
	//Convert the last row to a footer row.
	myTable.rows.item(-1).rowType = RowTypes.footerRow;
	//</fragment>
}
function myTeardown(){
}