Rem ComplexUI.vbs
Rem An InCopy VBScript
Rem 
Rem Shows how to create a more complex dialog box.
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
	myDisplayDialog myInCopy
End Function
Function myTeardown(myInCopy)
End Function
Function myDisplayDialog(myInCopy)
	ReDim mySwatchNames(myInCopy.Swatches.Count -1)
    For myCounter = 1 To myInCopy.Swatches.Count
        Set mySwatch = myInCopy.Swatches.Item(myCounter)
        mySwatchNames(myCounter - 1) = mySwatch.Name
	Next
	Set myDialog = myInCopy.Dialogs.Add
	myDialog.CanCancel = True
	myDialog.Name = "ComplexUI"
	Rem Create a dialog column.
	With myDialog.DialogColumns.Add
		Rem Create a border panel.
		With .BorderPanels.Add
			With .DialogColumns.Add
				With .DialogRows.Add
					With .StaticTexts.Add
						.StaticLabel = "Message:"
					End With
					Set myTextEditField = .TextEditboxes.Add
					myTextEditField.EditContents = "Hello World!"
					myTextEditField.MinWidth = 180
				End With
			End With
		End With
		With .BorderPanels.add
			With .DialogColumns.Add
				With .DialogRows.Add
					With .StaticTexts.Add
						.StaticLabel = "Point Size:"
					End With
					Set myPointSizeField = .MeasurementEditboxes.Add
					myPointSizeField.EditUnits = idMeasurementUnits.idPoints
					myPointSizeField.EditValue = 72
				End With
			End With
		End with
		With .BorderPanels.Add
			With .DialogColumns.Add
				With .DialogRows.Add
					With .StaticTexts.Add
						.StaticLabel = "Paragraph Alignment:"
					End With
					Set myRadioButtonGroup = .RadiobuttonGroups.Add
					With myRadioButtonGroup
						With .RadiobuttonControls.Add
							.StaticLabel = "Left"
							.CheckedState = True
						End With
						With .RadiobuttonControls.Add
							.StaticLabel = "Center"
						End With
						With .RadiobuttonControls.Add
							.StaticLabel = "Right"
						End With
					End With
				End With
			End With
		End With
		With .BorderPanels.Add
			With .DialogColumns.Add
				With .DialogRows.Add
					With .StaticTexts.Add
						.StaticLabel = "Text Color:"
					End With
					Set mySwatchDropdown = .Dropdowns.Add
					mySwatchDropdown.StringList = mySwatchNames
					mySwatchDropdown.SelectedIndex = 2
				End With
			End With
		End With
	End With	
	Rem If the user clicked OK, then create the example document.
	If myDialog.Show = True Then
		Rem Get the values from the dialog box controls.
		myString = myTextEditField.EditContents
		myPointSize = myPointSizeField.EditValue
		myParagraphAlignment = myRadioButtonGroup.SelectedButton
		mySwatchName = mySwatchNames(mySwatchDropdown.SelectedIndex)
		myDialog.Destroy
		myCreateExampleDocument myInCopy, myString, myPointSize, myParagraphAlignment, mySwatchName
	Else
		myDialog.Destroy
	End If
End Function
Function myCreateExampleDocument(myInCopy, myString, myPointSize, myParagraphAlignment, mySwatchName)
	Set myDocument = myInCopy.Documents.Add
	Set myStory = myDocument.Stories.Item(1)
	Rem Enter the text from the dialog box in the story.
	myStory.Contents = myString
	Rem Set the size of the text to the size you entered in the dialog box.
	myStory.Texts.Item(1).PointSize = myPointSize
	Rem set the paragraph alignment of the text to the dialog radio button choice.
	Select Case myParagraphAlignment
		Case 0
			myStory.Texts.Item(1).Justification = idJustification.idLeftAlign
		Case 1
			myStory.Texts.Item(1).Justification = idJustification.idCenterAlign
		Case Else
			myStory.Texts.Item(1).Justification = idJustification.idRightAlign
	End Select
	Rem Apply the selected swatch to the fill of the text.
	myStory.Texts.Item(1).FillColor = myDocument.Swatches.Item(mySwatchName)
End function