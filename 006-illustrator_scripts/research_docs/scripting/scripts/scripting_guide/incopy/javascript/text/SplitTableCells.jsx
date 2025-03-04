//SplitTableCells.jsx
//An InCopy JavaScript
//
//Shows how to split cells, column, and rows in a table.
//
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
	var myRowCounter, myRow, myCellCounter;
	var myDocument = app.documents.add();
	var myStory = myDocument.stories.item(0);
	var myString = "Table\r";
	myStory.contents = myString;
	var myTable = myStory.insertionPoints.item(-1).tables.add();
	myTable.columnCount = 1;
	myTable.bodyRowCount = 1;
	var myArray = myGetBounds(myDocument, myDocument.pages.item(0))
	var myWidth = myArray[3]-myArray[1];
	myTable.columns.item(0).width = myWidth;	
	myTable.cells.item(0).split(HorizontalOrVertical.horizontal);
	myTable.columns.item(0).split(HorizontalOrVertical.vertical);
	myTable.cells.item(0).split(HorizontalOrVertical.vertical);
	myTable.rows.item(-1).split(HorizontalOrVertical.horizontal);
	myTable.cells.item(-1).split(HorizontalOrVertical.vertical);
	for(myRowCounter = 0; myRowCounter < myTable.rows.length; myRowCounter ++){
		myRow = myTable.rows.item(myRowCounter);
		for(myCellCounter = 0; myCellCounter < myRow.cells.length; myCellCounter ++){
			myString = "Row: " + myRowCounter + " Cell: " + myCellCounter;
			myRow.cells.item(myCellCounter).contents = myString;
		}
	}
	//</fragment>
}
function myTeardown(){
}
function myGetBounds(myDocument, myPage){
	var myPageWidth = myDocument.documentPreferences.pageWidth;
	var myPageHeight = myDocument.documentPreferences.pageHeight
	if(myPage.side == PageSideOptions.leftHand){
		var myX2 = myPage.marginPreferences.left;
		var myX1 = myPage.marginPreferences.right;
	}
	else{
		var myX1 = myPage.marginPreferences.left;
		var myX2 = myPage.marginPreferences.right;
	}
	var myY1 = myPage.marginPreferences.top;
	var myX2 = myPageWidth - myX2;
	var myY2 = myPageHeight - myPage.marginPreferences.bottom;
	return [myY1, myX1, myY2, myX2];
}
