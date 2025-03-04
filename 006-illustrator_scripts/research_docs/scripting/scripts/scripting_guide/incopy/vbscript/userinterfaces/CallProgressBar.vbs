Rem CallProgressBar.vbs
Rem An InCopy VBScript
Rem
Rem Displays a ScriptUI progress bar created by the
Rem ProgressBar.jsx example script.
main
Function main
	Set myInCopy = CreateObject("InCopy.Application.2024")
	mySetup myInCopy
	mySnippet myInCopy
	myTeardown myInCopy
End Function
Function mySetup(myInCopy)
	myJavaScript = myFindFile(myInCopy, "\ProgressBar.jsx")
	myInCopy.DoScript myJavaScript, idScriptLanguage.idJavaScript
End Function
Function mySnippet(myInCopy)
	Rem <fragment>
	Rem Create a document and add pages to it--
	Rem if you do not do this, the progress bar
	Rem will go by too quickly.
	Set myDocument = myInCopy.Documents.Add
	Set myStory = myDocument.Stories.Item(1)
	Rem Note that the JavaScripts must use the "session"
	Rem engine for this to work.
	myString = "#targetengine ""session""" & vbCr
	myString = myString & "myCreateProgressPanel(100, 400);" & vbcr
	myString = myString & "myProgressPanel.show();" & vbcr
	myInCopy.DoScript myString, idScriptLanguage.idJavascript
	For myCounter = 1 to 100
		Rem Add a character to the story.
		myStory.InsertionPoints.Item(-1).Contents = "x"
		myString = "#targetengine ""session""" & vbCr
		myString = myString & "myProgressPanel.myProgressBar.value = " 
		myString = myString & cstr(myCounter) & "/myIncrement;" & vbcr
		myInCopy.DoScript myString, idScriptLanguage.idJavascript
		If(myCounter = 100) Then
			myString = "#targetengine ""session""" & vbCr
			myString = myString & "myProgressPanel.myProgressBar.value = 0;" & vbcr
			myString = myString & "myProgressPanel.hide();" & vbcr
			myInCopy.DoScript myString, idScriptLanguage.idJavascript
		End If
	Next
	myDocument.Close idSaveOptions.idNo
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
	myDialog.Filter = "JavaScript Files|*.jsx"
	myDialog.InitialDir = myFolder
	myResult = myDialog.ShowOpen	 
	If myResult = 0 Then
	    myFileName = ""
	Else
		myFileName = myDialog.FileName
	End If
	myGetFileName = myFileName
End Function