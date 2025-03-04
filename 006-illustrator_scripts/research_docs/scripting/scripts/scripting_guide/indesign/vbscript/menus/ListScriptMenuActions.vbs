Rem ListScriptMenuActions.vbs
Rem An InDesign VBScript
Rem 
Rem Create a list of all current script menu actions.
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
	Rem ![List script menu actions.]
	Set myFileSystemObject = CreateObject("Scripting.FileSystemObject")
	Rem You'll need to fill in a valid file path for your system.
	Set myTextFile = myFileSystemObject.CreateTextFile("c:\scriptmenuactions.txt", True, False)
	For myCounter = 1 To myInDesign.ScriptMenuActions.Count
		Set myScriptMenuAction = myInDesign.ScriptMenuActions.Item(myCounter)
		myTextFile.WriteLine myScriptMenuAction.Name
	Next
	myTextFile.Close
	Rem ![List script menu actions.]
End Function
Function myTeardown(myInDesign)
End Function