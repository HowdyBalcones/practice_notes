Rem MultipleEventListeners.vbs
Rem An InCopy VBScript
Rem
Rem Shows that multiple event listeners can respond to an event. The
Rem event handler scripts triggered by the two event listeners defined
Rem in this script are triggered when you import a file. To remove
Rem these event listeners, run the RemoveMultipleEventListeners.vbs
Rem script or quit and restart InCopy.
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
	Rem Define the handler as a file named "GetEventInfo.vbs" stored
	Rem in the same folder as this script.
	myFileName = myFindFile(myInCopy, "\GetEventInfo.vbs")
	If myFileName <> "" Then
		Set myEventListener = myInCopy.EventListeners.Add("beforeImport", myFileName)
	End If
	Set myDocument = myInCopy.Documents.Add
	myFileName = myFindFile(myInCopy, "\Message.vbs")
	If myFileName <> "" Then
		Set myEventListener = myInCopy.EventListeners.Add("beforeImport", myFileName)
	End If
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
