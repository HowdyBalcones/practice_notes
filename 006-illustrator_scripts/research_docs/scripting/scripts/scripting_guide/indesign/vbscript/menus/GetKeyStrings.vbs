Rem GetKeyStrings.vbs
Rem An InDesign VBScript
Rem
Rem Displays the locale-independent name of an item.
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
	Rem ![Get key strings.]
	Rem Fill in the name of the menu action you want.
	Set myMenuAction = myInDesign.MenuActions.Item("Convert to Note")
	myKeyStrings = myInDesign.FindKeyStrings(myMenuAction.Name)
	myString = ""
	For Each myKeyString In myKeyStrings
		myString = myString & myKeyString & vbCr
	Next
	MsgBox myString
	Rem ![Get key strings.]
End Function
Function myTeardown(myInDesign)
End Function