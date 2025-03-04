//IterateAssignmentProperty.jsx
//An InCopy CS5JavaScript
//
//Shows how to iterate assignment properties.
main();
function main(){
	mySetup();
	mySnippet();
	myTeardown();
}
function mySetup(){
}
function mySnippet(){
	myIterateAssignmentProperty();
	
}
function myTeardown(){
}
function myIterateAssignmentProperty()
{
	var myDocument = app.documents.item(0);
	var myAssignement = myDocument.assignments.item(0);
	var myuserName = myAssignement.userName;
	var myFilePath = myAssignement.filePath;
	var myDocPath =  myAssignement.documentPath;
	var myFramecolor = myAssignement.frameColor;
	var myincludeLinksWhenPackage =myAssignement.includeLinksWhenPackage; 
	var myExportOptions =  myAssignement.exportOptions;
}