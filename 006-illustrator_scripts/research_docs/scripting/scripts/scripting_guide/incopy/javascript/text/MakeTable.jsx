//MakeTable.jsx
//An InCopy JavaScript
//
//Shows how to create a table.
main();
function main(){
	mySetup();
	mySnippet();
	myTeardown();
}
function mySetup(){
	var myDocument = app.documents.add();
	var myStory = myDocument.stories.item(0);
	var myString = "Table 1\r";
	myString += "Column 1\tColumn 2\tColumn 3\r1a\t1b\t1c\r2a\t2b\t2c\r3a\t3b\t3c\r";
	myString += "Table 2\r";
	myString += "Column 1,Column 2,Column 3;1a,1b,1c;2a,2b,2c;3a,3b,3c\r";
	myString += "Table 3\r";
	myStory.contents = myString;
}
function mySnippet(){
	//<fragment>
	var myDocument = app.documents.item(0);
	var myStory = myDocument.stories.item(0);
	var myStartCharacter = myStory.paragraphs.item(6).characters.item(0);
	var myEndCharacter = myStory.paragraphs.item(6).characters.item(-2);
	var myText = myStory.texts.itemByRange(myStartCharacter, myEndCharacter);
	//The convertToTable method takes three parameters:
	//[ColumnSeparator as string]
	//[RowSeparator as string]
	//[NumberOfColumns as integer] (only used if the ColumnSeparator
	//and RowSeparator values are the same)
	//In the last paragraph in the story, columns are separated by commas
	//and rows are separated by semicolons, so we provide those characters
	//to the method as parameters.
	var myTable = myText.convertToTable(",",";");
	var myStartCharacter = myStory.paragraphs.item(1).characters.item(0);
	var myEndCharacter = myStory.paragraphs.item(4).characters.item(-2);
	var myText = myStory.texts.itemByRange(myStartCharacter, myEndCharacter);
	//In the second through the fifth paragraphs, colums are separated by
	//tabs and rows are separated by returns. These are the default delimiter
	//parameters, so we don't need to provide them to the method.
	var myTable = myText.convertToTable();
	//You can also explicitly add a table--you don't have to convert text to a table.
	var myTable = myStory.insertionPoints.item(-1).tables.add();
	myTable.columnCount = 3;
	myTable.bodyRowCount = 3;
	//</fragment>
}
function myTeardown(){
}