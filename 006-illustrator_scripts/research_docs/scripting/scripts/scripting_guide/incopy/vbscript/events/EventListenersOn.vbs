Rem EventListenersOn.vbs
Rem An InCopy VBScript
Rem
Rem Installs event listeners for all supported events; displays a
Rem message when each event occurs.
Rem
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
	myEventNames = Array("beforeQuit", "afterQuit", "beforeNew", "afterNew", "beforeOpen", "afterOpen", "beforeClose", "afterClose", "beforeSave", "afterSave", "beforeSaveAs", "afterSaveAs", "beforeSaveACopy", "afterSaveACopy", "beforeRevert", "afterRevert", "beforePrint", "afterPrint", "beforeExport", "afterExport", "beforeImport", "afterImport", "beforePlace", "afterPlace")
	Rem Define the handler as a file named "GetEventInfo.vbs" stored
	Rem in the same folder as this script.
	myFileName = myFindFile(myInCopy, "\GetEventInfo.vbs")
	If myFileName <> "" Then
		For myCounter = 0 To UBound(myEventNames)
			myInCopy.AddEventListener myEventNames(myCounter), myFileName, False
		Next
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