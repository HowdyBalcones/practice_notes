//RemoveEventListeners,jsx
//An InCopy JavaScript
//
//Removes the event listener created by the MultipleEventListeners.jsx script.
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
    app.removeEventListener("beforeImport", myEventInfo, false);
	if(app.documents.length != 0){
		app.documents.item(0).removeEventListener("beforeImport", myEventInfo, false);
	}
    //</fragment>
}
function myTeardown(){
}