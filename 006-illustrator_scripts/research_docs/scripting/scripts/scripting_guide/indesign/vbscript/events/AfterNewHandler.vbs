Rem AfterNewHandler.vbs
Rem An InDesign VBScript
Rem
Rem Adds metadata to a new document.
Rem <fragment>
myAddMetadata evt
Function myAddMetadata(myEvent)
	Set myInDesign = CreateObject("InDesign.Application.2024")
	myFileName = myFindFile(myInDesign, "\AfterNewDoScript.vbs")
	Rem Because the afterNew event is triggered before the document
	Rem is actually created, we need to run the script from outside
	Rem InDesign. To do this, we'll use the WScript Shell.
	Set WSHShell = CreateObject("WScript.Shell") 
	WSHShell.Run "wscript " & myFileName
End Function
Rem </fragment>
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
	myJavaScript = "myFilePath = File.openDialog(""Select the script file AfterNewDoScript.vbs"", ""VBScript files:*.vbs"");"
	myFilePath = myInDesign.doScript(myJavaScript, idScriptLanguage.idJavascript)
	myGetFileName = myFilePath
End Function
