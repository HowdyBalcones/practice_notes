//AfterNew.jsx
//An InCopy JavaScript
//
//Creates an event listener that will run after a new document is created.
#targetengine "session"
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
	var myEventListener = app.eventListeners.add("afterNew", myAfterNewHandler, false);
    //</fragment>
}
function myTeardown(){
}
//<fragment>
function myAfterNewHandler(myEvent){
	if((myEvent.target.constructor.name == "Document")&&(myEvent.eventPhase == EventPhases.bubblingPhase)){
		alert("handling event");
		var myDocument = myEvent.parent;
		myDocument.metadataPreferences.author = "Adobe Systems";
		myDocument.metadataPreferences.description = "This is a sample document with XMP metadata.";
	}
}
//</fragment>