//AddEventListener.jsx
//An InCopy JavaScript
//Creates a simple event listener.
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
	var myEventListener = app.addEventListener("afterNew", myDisplayEventType, false);
    //</fragment>
}
function myTeardown(){
}
//<fragment>
function myDisplayEventType(myEvent){
	alert("This event is the " + myEvent.eventType + " event.");
}
//</fragment>