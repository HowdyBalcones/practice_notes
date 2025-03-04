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
    var myNote = myStory.insertionPoints.item(-1).notes.add();
    //Add text to the note
    myNote.texts.item(0).contents = "This is a note."
}
function mySnippet(){
    var myDocument = app.documents.item(0);
    var myStory = myDocument.stories.item(0);
    var myNote = myStory.notes.item(0);
    //Expand/Collapse note
    myNote.collapsed = false; 
}
function myTeardown(){
}
