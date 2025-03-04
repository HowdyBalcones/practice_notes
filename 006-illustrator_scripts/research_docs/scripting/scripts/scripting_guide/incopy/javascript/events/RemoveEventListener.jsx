//RemoveEventListener,jsx
//An InCopy JavaScript
//
//Removes the event listener created by the AddEventListener script.
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
    app.removeEventListener("afterNew", myDisplayEventType, false);
    //</fragment>
}
function myTeardown(){
}