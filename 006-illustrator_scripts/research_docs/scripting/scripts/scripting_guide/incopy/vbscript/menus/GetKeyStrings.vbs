Rem GetKeyStrings.vbs
Rem An InCopy VBScript
Rem
Rem Displays the locale-independent name of an item.
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
	Rem Fill in the name of the menu action you want.
	Set myMenuAction = myInCopy.MenuActions.Item("Convert to Note")
	myKeyStrings = myInCopy.FindKeyStrings(myMenuAction.Name)
	myString = ""
	For Each myKeyString In myKeyStrings
		myString = myString & myKeyString & vbCr
	Next
	MsgBox myString
	Rem </fragment>
End Function
Function myTeardown(myInCopy)
End Function
