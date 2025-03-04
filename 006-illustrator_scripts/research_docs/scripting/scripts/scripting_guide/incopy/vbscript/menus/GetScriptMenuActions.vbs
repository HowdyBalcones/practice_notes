Rem GetScriptMenuActions.vbs
Rem An InCopy VBScript
Rem
Rem Gets the names of all script menu actions and writes them to a text file.
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
	Set myFileSystemObject = CreateObject("Scripting.FileSystemObject")
	Rem You'll need to fill in a valid file path on your system.
	Set myTextFile = myFileSystemObject.CreateTextFile("c:\script menu actions.txt", True, False)
	For myCounter = 1 To myInCopy.ScriptMenuActions.Count
	    Set myScriptMenuAction = myInCopy.ScriptMenuActions.Item(myCounter)
	    myTextFile.WriteLine myScriptMenuAction.Name
	Next
	myTextFile.Close
	MsgBox "done!"
	Rem </fragment>
End Function
Function myTeardown(myInCopy)
End Function
