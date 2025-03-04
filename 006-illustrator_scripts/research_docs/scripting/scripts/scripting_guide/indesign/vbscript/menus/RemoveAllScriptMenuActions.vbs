Rem RemoveAllScriptMenuActions.vbs
Rem An InDesign VBScript
Rem 
Rem Removes all of the current script menu actions.
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
	Rem ![Remove all script menu actions.]
	For myCounter = myInDesign.ScriptMenuActions.Count To 1 Step -1
		myInDesign.ScriptMenuActions.Item(myCounter).Delete
	Next
	Rem ![Remove all script menu actions.]
End Function
Function myTeardown(myInDesign)
End Function