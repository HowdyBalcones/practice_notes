Rem BeforePrint.vbs
Rem An InDesign VBScript
Rem
Rem Adds an event listener that performs a preflight check on
Rem a document before printing. If the preflight check fails, 
Rem the script gives the user the opportunity to cancel the print job.
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
	Rem ![Before print.]
	Rem Find the script file BeforePrintHandler.vbs in the same folder
	Rem as this script.
	myFileName = myFindFile(myInDesign, "\BeforePrintHandler.vbs")
	If myFileName <> "" Then
		Set myEventListener = myInDesign.EventListeners.Add("beforePrint", myFileName)
	End if
	Rem ![Before print.]
End Function
Function myTeardown(myInDesign)
End Function
Function myFindFile(myInDesign, myRelativePath)
	myFilePath = myInDesign.ActiveScript
	Set myFileSystemObject = CreateObject("Scripting.FileSystemObject")
	myFolderPath = myFileSystemObject.GetFile(myFilePath).ParentFolder.Path
	myFilePath = myFolderPath & myRelativePath
	If myFileSystemObject.FileExists(myFilePath) = True Then
		myFile = myFilePath
	Else
		myFile = myGetFileName(myInDesign)
	End If
	myFindFile = myFile
End Function
Function myGetFileName(myInDesign)
	myJavaScript = "myFilePath = File.openDialog(""Select the script file BeforePrintHandler.vbs"", ""VBScript files:*.vbs"");"
	myFilePath = myInDesign.doScript(myJavaScript, idScriptLanguage.idJavascript)
	myGetFileName = myFilePath
End Function
