//PlaceTextFile.jsx
//An InCopy JavaScript
//
//Places a text file in the default story of a new document.
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
	//Parameters for InsertionPoint.place():
	//File as File object, 
	//[ShowingOptions as Boolean = False]
	//You'll have to fill in your own file path.
	myDocument.stories.item(0).insertionPoints.item(0).place(File("/c/test.txt"), false);
	//</fragment>
}
function myTeardown(){
}
