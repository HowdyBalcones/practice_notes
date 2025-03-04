Rem RemoveMultipleEventListeners.vbs
Rem An InCopy VBScript
Rem
Rem Removes the event listeners added by the 
Rem MultipleEventListeners.vbs script.
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
	myFileName = myFindFile(myInCopy, "\GetEventInfo.vbs")
	Set myFileSystemObject = CreateObject("Scripting.FileSystemObject")
	Set myFile = myFileSystemObject.GetFile(myFileName)		
	myResult = myInCopy.RemoveEventListener("beforeImport", myFile)
	If myResult = True Then
		MsgBox "Event listener removed."
	Else
		MsgBox "Event listener not removed."
	End If
	If myInCopy.Documents.Count <> 0 Then
		myDocument = myInCopy.Documents.Item(1)
		myFileName = myFindFile(myInCopy, "\Message.vbs")
		Set myFile = myFileSystemObject.GetFile(myFileName)		
		myResult = myInCopy.RemoveEventListener("beforeImport", myFile)
		If myResult = True Then
			MsgBox "Event listener removed."
		Else
			MsgBox "Event listener not removed."
		End If
	End if
End Function
Function myTeardown(myInCopy)
End Function
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
