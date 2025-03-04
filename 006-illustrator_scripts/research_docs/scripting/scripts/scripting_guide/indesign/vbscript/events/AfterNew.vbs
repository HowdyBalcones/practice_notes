Rem AfterNew.vbs
Rem An InDesign VBScript
Rem
Rem Adds an event listener to the afterNew event. Calls
Rem a script on disk to set up basic document parameters
Rem and XMP metadata. To remove the event listener,
Rem either quit and restart InDesign or run the 
Rem RemoveAfterNew.vbs script.
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
	Rem ![After new.]
	Rem Define the handler as a file named "AfterNewHandler.vbs" stored
	Rem in the same folder as this script.
	myFileName = myFindFile(myInDesign, "\AfterNewHandler.vbs")
	If myFileName <> "" Then
		Set myEventListener = myInDesign.EventListeners.Add("afterNew", myFileName)
	End If
	Rem ![After new.]
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
	myJavaScript = "myFilePath = File.openDialog(""Select the script file AfterNewHandler.vbs"", ""VBScript files:*.vbs"");"
	myFilePath = myInDesign.doScript(myJavaScript, idScriptLanguage.idJavascript)
	myGetFileName = myFilePath
End Function