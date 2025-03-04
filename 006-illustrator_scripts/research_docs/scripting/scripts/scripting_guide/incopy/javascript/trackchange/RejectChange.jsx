//RejectChange.jsx
//An InCopy JavaScript
//
//Reject change.
main();
function main(){
	mySetup();
	mySnippet();
	myTeardown();
}
function mySetup(){
}
function mySnippet(){
	
	myRejectChange();
}
function myTeardown(){
}

function myRejectChange()
{
	var myDocument = app.documents.item(0);
	var myCount = myDocument.assignments.count();
	var myStory = myDocument.stories.item(0);
	var myChange = myStory.changes.item(0);
	myChange.reject() ;
	
}