//GetAssignmentStory.jsx
//An InCopy JavaScript
//
//Shows how to get assignment stories from assignment.
main();
function main(){
	mySetup();
	mySnippet();
	myTeardown();
}
function mySetup(){
}
function mySnippet(){
	myGetAssignmentStory();
}
function myTeardown(){
}
function myGetAssignmentStory()
{
	var myDocument = app.documents.item(0);
	var myAssignement = myDocument.assignments.item(0);
	var myAssignmentSotry = myAssignement.assignedStories.item(0);

}