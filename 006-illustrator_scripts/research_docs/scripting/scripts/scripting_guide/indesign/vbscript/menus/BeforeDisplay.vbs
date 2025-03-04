Rem BeforeDisplay.vbs
Rem An InDesign VBScript
Rem
Rem Shows how to add a beforeDisplay event listener to a menu item.
Rem To remove this menu, run the RemoveBeforeDisplay.vbs script.
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
	Rem ![Before display.]
	Rem Find the script file WhatIsSelected.vbs in the same folder as this script.
	myFileNameA = myFindFile(myInDesign, "\WhatIsSelected.vbs")
	Rem Find the script file BeforeDisplayHandler.vbs in the same folder as this script.
	myFileNameB = myFindFile(myInDesign, "\BeforeDisplayHandler.vbs")
	Rem If either of the two files are not found, do nothing.
	If myFileNameA <> "" And myFileNameB <> "" Then	
		Set mySampleScriptAction = myInDesign.ScriptMenuActions.Add("Display Message")
		Set myEventListener = mySampleScriptAction.EventListeners.Add("onInvoke", myFileNameA)
		Set mySampleScriptMenu = myInDesign.Menus.Item("$ID/Main").Submenus.Add("Script Menu Action")
		Set mySampleScriptMenuItem = mySampleScriptMenu.MenuItems.Add(mySampleScriptAction)
		mySampleScriptMenu.EventListeners.Add "beforeDisplay", myFileNameB
	End If
	Rem ![Before display.]
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
		myFile = myGetFileName(myInDesign,myRelativePath)
	End If
	myFindFile = myFile
End Function
Function myGetFileName(myInDesign, myRelativePath)
	myParameters = Array(myRelativePath)
	myJavaScript = "myFilePath = File.openDialog(""Select the script file "" + arguments[0]);"
	myFilePath = myInDesign.doScript(myJavaScript, idScriptLanguage.idJavascript, myParameters)
	myGetFileName = myFilePath
End Function
