//IterateAssignmentStoryProperty.jsx
//An InCopy JavaScript
//
//Shows how to Iterate assignment story properties.
main();
function main(){
	mySetup();
	mySnippet();
	myTeardown();
}
function mySetup(){
}
function mySnippet(){
	
	myIterateAssignmentStoryProperty();
}
function myTeardown(){
}
function myIterateAssignmentStoryProperty()
{
	var myDocument = app.documents.item(0);
	var myAssignement = myDocument.assignments.item(0);
	var myAssignmentStory = myAssignement.assignedStories.item(0);
	if(myAssignmentStory != null)
	{
		var myName = myAssignmentSotry.name;
		var myIsvalid = myAssignmentSotry.isValid;
		var myFilePath = myAssignmentSotry.filePath;
		var myStoryReference =myAssignmentSotry.storyReference;
	}


}