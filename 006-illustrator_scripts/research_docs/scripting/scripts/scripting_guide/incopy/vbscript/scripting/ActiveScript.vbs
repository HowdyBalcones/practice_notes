Rem ActiveScript.vbs
Rem An InCopy VBScript
Rem
Rem Gets the active script.
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
	myActiveScript = myInCopy.ActiveScript
	MsgBox ("The current script is: " & myActiveScript)
	Set myFileSystemObject = CreateObject("Scripting.FileSystemObject")
	myParentFolder = myFileSystemObject.GetFile(myActiveScript).ParentFolder
	MsgBox ("The folder containing the active script is: " & myParentFolder)
End Function
Function myTeardown(myInCopy)
End Function

