Rem ExportAllStories.vbs
Rem An InCopy VBScript
Rem
Rem Exports all stories in an InCopy document in a specified text format.
Rem InCopy will export each story as a separate file, and will name each
Rem file with the ID of the story (each ID is unique within a document).
Rem
main
Function main()
	Set myInCopy = CreateObject("InCopy.Application.2024")
	Rem Set the user interaction level to allow the display of dialog boxes and alerts.
	myInCopy.ScriptPreferences.UserInteractionLevel = idUserInteractionLevels.idInteractWithAll
	If myInCopy.Documents.Count > 0 Then
	    If myInCopy.ActiveDocument.Stories.Count > 0 Then
	        myDisplayDialog myInCopy
	    Else
	        MsgBox ("The active document does not contain any text. Please open a document containing text and try again.")
	    End If
	Else
	    MsgBox ("No documents are open. Please open a document and try again.")
	End If
End Function
Function myDisplayDialog(myInCopy)
    Set myDialog = myInCopy.Dialogs.Add
    myDialog.Name = "ExportAllStories"
    With myDialog
        Rem Add a dialog column.
        With .DialogColumns.Add
            With .BorderPanels.Add
                With .StaticTexts.Add
                    .StaticLabel = "Export as:"
                End With
                Set myExportFormatButtons = .RadiobuttonGroups.Add
                With myExportFormatButtons
                    With .RadiobuttonControls.Add
                        .StaticLabel = "Text Only"
                        .CheckedState = True
                    End With
                    With .RadiobuttonControls.Add
                        .StaticLabel = "RTF"
                    End With
                    With .RadiobuttonControls.Add
                        .StaticLabel = "InCopy Tagged Text"
                    End With
                End With
            End With
        End With
    End With
    myReturn = myDialog.Show
    If myReturn = True Then
        Rem Get the values from the dialog box.
        myExportFormat = myExportFormatButtons.SelectedButton
        myDialog.Destroy
        Rem Creating a folder browser in VBScript can be difficult,
        Rem So we'll use InCopy's built-in JavaScript to display a
        Rem file browser.
        myJavaScript = "myFolder = Folder.selectDialog(""Choose a Folder"");app.activeDocument.insertLabel(""TargetFolder"", myFolder.fsName);"
        myInCopy.DoScript myJavaScript, idScriptLanguage.idJavascript
        Rem Now get the stored folder path from the label.
        myFolder = myInCopy.ActiveDocument.ExtractLabel("TargetFolder")
        Rem Now get the stored folder path from the label.
        myFolder = myInCopy.ActiveDocument.ExtractLabel("TargetFolder")
        If ((myFolder <> "") And (myInCopy.ActiveDocument.Stories.Count <> 0)) Then
            myExportAllStories myInCopy, myExportFormat, myFolder
        End If
    Else
        myDialog.Destroy
    End If
End Function
Rem myExportStories function takes care of exporting the stories.
Rem myExportFormat is a number from 0-2, where 0 = text only, 1 = rtf, and 3 = tagged text.
Rem myFolder is the path to the folder in which you want to save your files.
Function myExportAllStories(myInCopy, myExportFormat, myFolder)
    For myCounter = 1 To myInCopy.ActiveDocument.Stories.Count
        Set myStory = myInCopy.ActiveDocument.Stories.Item(myCounter)
        myID = myStory.Id
        Select Case myExportFormat
            Case 0:
                myFormat = idExportFormat.idTextType
                myExtension = ".txt"
            Case 1:
                myFormat = idExportFormat.idRTF
                myExtension = ".rtf"
            Case 2:
                myFormat = idExportFormat.idTaggedText
                myExtension = ".txt"
        End Select
        Rem DoScript(Script, [Language As idScriptLanguage = idUnknown])
        myFilePath = myFolder & "/" & "StoryID" & myID & myExtension
        myStory.Export myFormat, myFilePath
    Next
End Function
