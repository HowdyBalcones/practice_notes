Rem CustomizeMenu.vbs
Rem An InCopy VBScript
Rem
Rem Adds a custom menu to the main menu bar.
main
Function main()
	Set myInCopy = CreateObject("InCopy.Application.2024")
	mySetup myInCopy
	mySnippet myInCopy
	myTeardown myInCopy
End Function
Function mySetup(myInCopy)
End Function
Function mySnippet(myInCopy)
	Rem <fragment>
	Set myMainMenu = myInCopy.Menus.Item("Main")
	Set myTypeMenu = myMainMenu.MenuElements.Item("Type")
	Set myFontMenu = myTypeMenu.MenuElements.Item("Font")
	Set myKozukaMenu = myFontMenu.Submenus.Item("Kozuka Mincho Pro ")
	Set mySpecialFontMenu = myMainMenu.Submenus.Add("Kozuka Mincho Pro")
	For myCounter = 1 To myKozukaMenu.MenuItems.Count
		Set myAssociatedMenuAction = myKozukaMenu.MenuItems.Item(myCounter).AssociatedMenuAction
		mySpecialFontMenu.MenuItems.Add myAssociatedMenuAction
	Next	
	Rem </fragment>
End Function
Function myTeardown(myInCopy)
End Function
