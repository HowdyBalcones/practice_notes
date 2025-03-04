Rem MakeScriptMenuAction.vbs
Rem An InCopy VBScript
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
	Rem <fragment>
	Rem Adds a menu at the end of the main menu bar.
	Set mySampleScriptAction = myInCopy.ScriptMenuActions.add("Display Alert")
	myFileName = myFindFile(myInCopy, "\Message.vbs")
	Set myEventListener = mySampleScriptAction.EventListeners.Add("onInvoke", myFileName, false)
	Rem If the submenu "Script Menu Action" does not already exist, create it.
	Rem You might have to force InCopy to redraw the menu (by switching
	Rem out of the application and back again) to make the menu item appear.
	On Error Resume Next
	Set mySampleScriptMenu = myInCopy.Menus.Item("$ID/Main").Submenus.Item("Script Menu Action")
	If Err.Number <> 0 Then
		Set mySampleScriptMenu = myInCopy.Menus.Item("$ID/Main").Submenus.Add("Script Menu Action")
		Err.Clear
	End If
	On Error Goto 0
	Set mySampleScriptMenuItem = mySampleScriptMenu.menuItems.add(mySampleScriptAction)
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