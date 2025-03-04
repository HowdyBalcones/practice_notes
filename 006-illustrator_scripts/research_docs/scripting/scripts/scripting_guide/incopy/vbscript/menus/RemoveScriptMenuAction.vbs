Rem RemoveScriptMenuAction.vbs
Rem An InCopy VBScript
Rem 
Rem Removes a script menu action and its associated menu item.
Rem You might have to force InCopy to redraw the menu (by switching
Rem out of the application and back again) to make the menu item disappear.
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
	On Error Resume Next
	myInCopy.ScriptMenuActions.Item("Display Alert").Delete
	myInCopy.Menus.Item("$ID/Main").Submenus.Item("Script Menu Action").Delete
	On Error Goto 0
	Rem </fragment>
End Function
Function myTeardown(myInCopy)
End Function
