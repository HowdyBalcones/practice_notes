//OpenAssignment.jsx
//An InCopy JavaScript
//
//Shows how to open an InCopy document.
main();
function main(){
	mySetup();
	mySnippet();
	myTeardown();
}
function mySetup(){
}
function mySnippet(){
	myOpenIcmaDoc();
}
function myTeardown(){
}
function myOpenIcmaDoc()
{
	var myDocument = app.open(File("/c/a.icma"));
	var myAssignement = myDocument.assignments.item(0);
	
}
function myOpenIcapDoc()
{
	var myDocument = app.open(File("/c/a.icap"));
	var myAssignement = myDocument.assignments.item(0);
	
}