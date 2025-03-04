Rem InvokeMenuAction.vbs
Rem An InCopy VBScript
Rem
Rem Runs a menu action.
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
	Rem Get a reference to a menu action.
	Set myMenuAction = myInCopy.MenuActions.Item("$ID/Convert to Note")
	Rem Run the menu action. The example action will fail if you do not
	Rem have text selected.
	myMenuAction.Invoke
	Rem </fragment>
End Function
Function myTeardown(myInCopy)
End Function
