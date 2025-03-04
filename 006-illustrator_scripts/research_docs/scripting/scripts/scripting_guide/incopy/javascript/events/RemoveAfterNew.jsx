//RemoveEventListener.jsx
//An InCopy JavaScript
//
//Removes the event listener created by the AfterNew script.
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
    var myResult = app.removeEventListener("afterNew", myAfterNewHandler, false);
	if(myResult == true){
		alert("AfterNew event removed.");
	}
	else{
		alert("Event not removed.");
	}
    //</fragment>
}
function myTeardown(){
}