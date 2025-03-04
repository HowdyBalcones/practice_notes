Rem WhatIsSelected.vbs
Rem An InCopy VBScript
Rem
Rem This script is called by the BeforeDisplay.vbs tutorial script.
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
	myString = TypeName(myInCopy.Selection.Item(1))
	MsgBox "The first item in the selection is a " & myString & "."
	Rem </fragment>
End Function
Function myTeardown(myInCopy)
End Function