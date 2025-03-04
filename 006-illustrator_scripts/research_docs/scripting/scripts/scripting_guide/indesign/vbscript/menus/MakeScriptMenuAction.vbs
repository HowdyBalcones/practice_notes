Rem MakeScriptMenuAction.vbs
Rem An InDesign VBScript
Rem 
Rem Adds a menu at the end of the main menu bar. To remove this
Rem menu, run the script RemoveScriptMenuAction.vbs.
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
	Rem ![Make script menu action.]
	Set mySampleScriptAction = myInDesign.ScriptMenuActions.add("Display Alert")
	Rem You'll have to fill in your own file path for the event handler script.
	myFileName = myFindFile(myInDesign, "\Message.vbs")
	Set myEventListener = mySampleScriptAction.EventListeners.Add("onInvoke", myFileName, false)
	Rem If the submenu "Script Menu Action" does not already exist, create it.
	Rem You might have to force InDesign to redraw the menu (by switching
	Rem out of the application and back again) to make the menu item appear.
	On Error Resume Next
	Set mySampleScriptMenu = myInDesign.Menus.Item("$ID/Main").Submenus.Item("Script Menu Action")
	If Err.Number <> 0 Then
		Set mySampleScriptMenu = myInDesign.Menus.Item("$ID/Main").Submenus.Add("Script Menu Action")
		Err.Clear
	End If
	On Error Goto 0
	Set mySampleScriptMenuItem = mySampleScriptMenu.menuItems.add(mySampleScriptAction)
	Rem ![Make script menu action.]
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
        myFile = myGetFileName(myInDesign,myFolderPath)
    End If
    myFindFile = myFile
End Function
Function myGetFileName(myInDesign, myFolder)
    myJavaScript = "myFilePath = File.openDialog(""Select the script file Message.vbs"", ""VBScript files:*.vbs"");"
	myFilePath = myInDesign.doScript(myJavaScript, idScriptLanguage.idJavascript)
	myGetFileName = myFilePath
End Function