//MoveText.jsx
//An InCopy JavaScript
//
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
	//Create a series of paragraphs in the default story.
	var myStory = myDocument.stories.item(0);
	myStory.contents = "WordA\rWordB\rWordC\rWordD\r";
	//Move WordC before WordA.
	myStory.paragraphs.item(2).move(LocationOptions.before, myStory.paragraphs.item(0));
	//Move WordB after WordD (into the same paragraph).
	myStory.paragraphs.item(2).move(LocationOptions.after, myStory.paragraphs.item(-1).words.item(0));
	//Note that moving text removes it from its original location.}
	//</fragment>
}
function myTeardown(){
}
