Rem RemoveCustomMenu.vbs
Rem An InDesign VBScript
Rem 
Rem Shows how to remove the menu customization applied by CustomMenu.vbs.
Rem You might have to force InDesign to redraw the menu (by switching
Rem out of the application and back again) to make the menu item disappear.
main
Function main()
	Set myInDesign = CreateObject("InDesign.Application.2024")
	mySetup myInDesign
	mySnippet myInDesign
	myTeardown myInDesign
End Function
Function mySetup(myInDesign)
End Function
Function mySnippet(myInDesign)
	Rem ![Remove custom menu.]
	Set myMainMenu = myInDesign.menus.item("$ID/Main")
	On Error Resume Next
	Set mySpecialFontMenu = myMainMenu.Submenus.Item("Kozuka Mincho Pro")
	mySpecialFontMenu.Delete
	On Error Goto 0
	Rem ![Remove custom menu.]
End Function
Function myTeardown(myInDesign)
End Function