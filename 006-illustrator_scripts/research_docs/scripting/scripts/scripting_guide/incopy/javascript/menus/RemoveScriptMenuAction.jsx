//RemoveScriptMenuAction.jsx
//An InCopy JavaScript
//
//Removes the script menu action created by the MakeScriptMenuAction.jsx script 
//and removes the associated menu item.
//You might have to force InCopy to redraw the menu (by switching
//out of the application and back again) to make the menu item disappear.
#targetengine "session"
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
	try{
		app.scriptMenuActions.item("Display Alert").remove();
	}
	catch(myError){}
	try{
		app.menus.item("$ID/Main").submenus.item("Script Menu Action").remove();
	}
	catch(myError){}
	//</fragment>
}
function myTeardown(){
}
