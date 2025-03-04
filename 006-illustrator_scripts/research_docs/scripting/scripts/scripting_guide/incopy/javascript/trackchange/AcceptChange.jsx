//AcceptChange.jsx
//An InCopy JavaScript
//
//Accept change.
main();
function main(){
	mySetup();
	mySnippet();
	myTeardown();
}
function mySetup(){
}
function mySnippet(){
	
	myAcceptChange();
}
function myTeardown(){
}

function myAcceptChange()
{
	var myDocument = app.documents.item(0);
	var myStory = myDocument.stories.item(0);
	var myChange = myStory.changes.item(0);
	myChange.accept () ;
	
}
