Rem BeforeDisplayHandler.vbs
Rem An InCopy VBScript
Rem
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
	Set mySampleScriptAction = myInCopy.ScriptMenuActions.Item("Display Message")
	If myInCopy.Selection.Count > 0 Then
		mySampleScriptAction.Enabled = True
	Else
		mySampleScriptAction.Enabled = False
	End If
	Rem </fragment>
End Function
Function myTeardown(myInCopy)
End Function
