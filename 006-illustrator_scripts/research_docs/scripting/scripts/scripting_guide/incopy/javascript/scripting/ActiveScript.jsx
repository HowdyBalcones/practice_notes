//ActiveScript.jsx
//An InCopy JavaScript
//
//Demonstrates the use of the activeScript property.
main();
function main(){
	mySetup();
	mySnippet();
	myTeardown();
}
function mySetup(){
}
function mySnippet(){
	var myScript = app.activeScript;
	alert("The current script is: " + myScript);
	var myParentFolder = File(myScript).parent;
	alert("The folder containing the active script is: " + myParentFolder);
}
function myTeardown(){
}