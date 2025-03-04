//GetChange.jsx
//An InCopy JavaScript
//
//Shows how to get Track change from doc.
main();
function main(){
	mySetup();
	mySnippet();
	myTeardown();
}
function mySetup(){
}
function mySnippet(){
	
	myGetChangeFromDoc1();
}
function myTeardown(){
}
function myGetChangeFromDoc()
{
	var myDocument = app.documents.item(0);
	var myStory = myDocument.stories.item(0);
	//Story.trackChanges   If true, track changes is turned on.
	if(myStory.trackChanges==true )
	{
		var myChangeCount =myStory.changes.length;
		var myChange = myStory.changes.item(0);
		if(myChangeCount>1)
		{
			var myChange0 = myStory.changes.nextItem(myChange);
		}
	}
}

function myGetChangeFromDoc1()
{
	var myDocument = app.documents.item(0);
	var myStory = myDocument.stories.item(0);
	//Story.trackChanges   If true, track changes is turned on.
	if(myStory.trackChanges==true )
	{
		var myChangeCount =myStory.changes.length;
		var myChange = myStory.changes.lastItem();
		if(myChangeCount>1)
		{
			var myChange0 = myStory.changes.previousItem(myChange);
		}
	}

}