Rem RemoveEventListener.vbs
Rem An InCopy VBScript
Rem
Rem Removes the event listener created by the AddEventListener script.
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
	Rem Define the handler as a file named "Message.vbs" stored
	Rem in the same folder as this script.
	myFileName = myFindFile(myInCopy, "\Message.vbs")
	If myFileName <> "" Then
		Set myFileSystemObject = CreateObject("Scripting.FileSystemObject")
		Rem You must use a file reference, rather than a string, to remove
		Rem an event listener. In addition, the file location must match
		Rem the location of the file used to create the event listener.
		If myFileSystemObject.FileExists(myFileName) = True Then
			Set myFile = myFileSystemObject.GetFile(myFileName)		
			myResult = myInCopy.RemoveEventListener("afterNew", myFile, False)
			If myResult = True Then
				MsgBox "Event listener removed."
			Else
				MsgBox "Event listener not removed."
			End If
		End If
	Else
		MsgBox "Handler file not found."
	End If
	Rem </fragment>
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