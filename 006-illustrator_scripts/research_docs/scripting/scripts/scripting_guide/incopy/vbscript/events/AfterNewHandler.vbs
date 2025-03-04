Rem AfterNewHandler.vbs
Rem An InCopy VBScript
Rem
Rem Adds metadata to a new document.
Rem <fragment>
myAddMetadata evt
Function myAddMetadata(myEvent)
	Set myInCopy = CreateObject("InCopy.Application.2024")
	myFileName = myFindFile(myInCopy, "\AfterNewDoScript.vbs")
	Set WSHShell = CreateObject("WScript.Shell") 
	WSHShell.Run "wscript " & myFileName
End Function
Rem </fragment>
Function myFindFile(myInCopy, myRelativePath)
	myFilePath = myInCopy.ActiveScript
	Set myFileSystemObject = CreateObject("Scripting.FileSystemObject")
	myFolderPath = myFileSystemObject.GetFile(myFilePath).ParentFolder.Path
	myFilePath = myFolderPath & myRelativePath
	If myFileSystemObject.FileExists(myFilePath) = True Then
		myFile = myFilePath
	Else
		myFile = myGetFileName(myFolderPath)
	End If
	myFindFile = myFile
End Function
Function myGetFileName(myFolder)
	Set myDialog = CreateObject("UserAccounts.CommonDialog")
	myDialog.Filter = "VBScript files|*.vbs"
	myDialog.InitialDir = myFolder
	myResult = myDialog.ShowOpen	 
	If myResult = 0 Then
	    myFileName = ""
	Else
		myFileName = myDialog.FileName
	End If
	myGetFileName = myFileName
End Function
