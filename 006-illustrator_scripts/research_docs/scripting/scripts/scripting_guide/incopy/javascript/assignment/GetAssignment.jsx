//GetAssignment.jsx
//An InCopy JavaScript
//
//Shows how to get assignments from doc.
main();
function main(){
	mySetup();
	mySnippet();
	myTeardown();
}
function mySetup(){
}
function mySnippet(){
	
	myGetAssignmentFromDoc();
}
function myTeardown(){
}
function myGetAssignmentFromDoc()
{
	var myDocument = app.documents.item(0);
	var myCount = myDocument.assignments.count();
	if(myCount>0)
	{
		var myAssignement = myDocument.assignments.item(0);
	}
}