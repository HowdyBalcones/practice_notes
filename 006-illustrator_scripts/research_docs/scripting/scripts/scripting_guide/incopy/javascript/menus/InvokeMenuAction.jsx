//InvokeMenuAction.jsx
//An InCopy JavaScript
//
//Runs a specified menu action.
main();
function main(){
	mySetup();
	mySnippet()
	myTeardown()
}
function mySetup(){
}
function mySnippet(){
	//<fragment>
	//Get a reference to a menu action.
	var myMenuAction = app.menuActions.item("$ID/Convert to Note");
	//Run the menu action. This example action will fail if you do not
	//have text selected.
	myMenuAction.invoke();
	//</fragment>
}
function myTeardown(){
}
