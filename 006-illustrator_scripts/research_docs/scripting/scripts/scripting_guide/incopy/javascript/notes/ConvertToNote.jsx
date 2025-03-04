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
  //Convert text to note
  myStory.words.item(0).convertToNote();
}
function myTeardown(){
}


