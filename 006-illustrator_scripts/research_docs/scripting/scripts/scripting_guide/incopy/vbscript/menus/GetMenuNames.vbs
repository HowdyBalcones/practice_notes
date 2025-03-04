Rem GetMenuNames.vbs
Rem An InCopy VBScript
Rem
Rem Writes the names of all menus to a text file.
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
	Set myFileSystemObject = CreateObject("Scripting.FileSystemObject")
	Set myTextFile = myFileSystemObject.CreateTextFile("c:\incopy menu names.txt", True, False)
	For myMenuCounter = 1 To myInCopy.Menus.Count
		Set myMenu = myInCopy.Menus.Item(myMenuCounter)
		myTextFile.WriteLine myMenu.Name
		myProcessMenu myMenu, myTextFile
	Next
	myTextFile.Close
	MsgBox "done!"
	Rem </fragment>
End Function
Function myTeardown(myInCopy)
End Function
Function myProcessMenu(myMenuItem, myTextFile)
	myString = ""
	myMenuName = myMenuItem.Name
	For myCounter = 1 To myMenuItem.MenuElements.Count
		If TypeName(myMenuItem.MenuElements.Item(myCounter)) <> "MenuSeparator" Then
			myString = myGetIndent(myMenuItem.MenuElements.Item(myCounter),myString, False)
			myTextFile.WriteLine myString & myMenuItem.MenuElements.Item(myCounter).Name
			myMenuElementName = myMenuItem.MenuElements.Item(myCounter).Name
			myString = ""
			If TypeName(myMenuItem.MenuElements.Item(myCounter)) = "Submenu" Then
				If myMenuItem.MenuElements.Count > 0 Then
					myProcessMenu myMenuItem.MenuElements.Item(myCounter),myTextFile
				End If
			End If
		End If
	Next
End Function
Function myGetIndent(myMenuItem, myString, myDone)
	Do While myDone = False
		If TypeName(myMenuItem.Parent) = "Application" Then
			myDone = True
		Else
			myString = myString & vbTab
			myGetIndent myMenuItem.Parent, myString, myDone
		End If
	Loop
	myGetIndent = myString
End Function