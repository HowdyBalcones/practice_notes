Rem ActiveScript.vbs
Rem An InDesign VBScript
Rem
Rem Demonstrates the use of the ActiveScript property.
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
	Rem ![Getting the Current Script.]
	myActiveScript = myInDesign.ActiveScript
	MsgBox ("The current script is: " & myActiveScript)
	Set myFileSystemObject = CreateObject("Scripting.FileSystemObject")
	myParentFolder = myFileSystemObject.GetFile(myActiveScript).ParentFolder
	MsgBox ("The folder containing the active script is: " & myParentFolder)
	Rem ![Getting the Current Script.]
End Function
Function myTeardown(myInDesign)
End Function