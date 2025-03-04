Rem BeforeDisplay.vbs
Rem An InCopy VBScript
Rem
Rem Shows how to add a beforeDisplay event listener to a menu item.
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
	Set mySampleScriptAction = myInCopy.ScriptMenuActions.Add("Display Message")
	myFileName = myFindFile(myInCopy, "\WhatIsSelected.vbs")
	If myFileName <> "" Then
		Set myEventListener = mySampleScriptAction.EventListeners.Add("onInvoke", myFileName)
	End If
	Set mySampleScriptMenu = myInCopy.Menus.Item("$ID/Main").Submenus.Add("Script Menu Action")
	Set mySampleScriptMenuItem = mySampleScriptMenu.MenuItems.Add(mySampleScriptAction)
	myFileName = myFindFile(myInCopy, "\BeforeDisplayHandler.vbs")
	If myFileName <> "" Then
		mySampleScriptMenu.EventListeners.Add "beforeDisplay", myFileName
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