//An InCopy JavaScript

main();
function main(){
    mySetup();
    mySnippet();
    myTeardown();
}
function mySetup(){
	var myDocument = app.documents.add();
	var myStory = myDocument.stories.item(0);
  myStory.contents = "This is the first paragraph of example text.";

}
function mySnippet(){
  var myDocument = app.documents.item(0);
  var myStory = myDocument.stories.item(0);
  //Add note to a default story. We'll use the last insertion point in the story.
  var myNote = myStory.insertionPoints.item(-1).notes.add();
  //Add text to the note
  myNote.texts.item(0).contents = "This is a note."
}
function myTeardown(){
}