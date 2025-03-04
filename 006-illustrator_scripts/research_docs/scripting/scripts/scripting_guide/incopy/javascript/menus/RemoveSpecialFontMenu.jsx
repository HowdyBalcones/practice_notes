//RemoveSpecialFontMenu.jsx
//An InCopy JavaScript
//
//Removes the custom menu added by the CustomMenu.jsx script.
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
	var myMainMenu = app.menus.item("Main");
	var mySpecialFontMenu = myMainMenu.submenus.item("Kozuka Mincho Pro");
	mySpecialFontMenu.remove();
	//</fragment>
}
function myTeardown(){
}