Rem GetMenuActions.vbs
Rem An InCopy VBScript
Rem
Rem Gets the names of all menu actions and writes them to a text file.
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
	Set myTextFile = myFileSystemObject.CreateTextFile("c:\menuactions.txt", True, False)
	For myCounter = 1 To myInCopy.MenuActions.Count
	    Set myMenuAction = myInCopy.MenuActions.Item(myCounter)
	    myTextFile.WriteLine myMenuAction.Name
	Next
	myTextFile.Close
	MsgBox "done!"
	Rem </fragment>
End Function
Function myTeardown(myInCopy)
End Function
