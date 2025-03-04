Rem ApplyFont.vbs
Rem An InCopy VBScript
Rem
Rem Applies a font to example text.
Rem
Rem NOTE: Getting a list of font names can be very slow!
main
Function main()
	Set myInCopy = CreateObject("InCopy.Application.2024")
	mySetup myInCopy
	mySnippet myInCopy
	myTeardown myInCopy
End Function
Function mySetup(myInCopy)
	Set myDocument = myInCopy.Documents.Add
	set myStory = myDocument.Stories.Item(1)
	set myTextFrame = myStory.TextContainers.Item(1)
	myTextFrame.Contents = idTextFrameContents.idPlaceholderText
End Function
Function mySnippet(myInCopy)
	Rem<fragment>
	Set myStory = myInCopy.Documents.Item(1).Stories.Item(1)
	Set myText = myStory.Texts.Item(1)
	myDisplayDialog myInCopy, myText
	Rem</fragment>
End Function
Function myTeardown(myInCopy)
End Function
Rem<fragment>
Function myDisplayDialog(myInCopy, myText)
	ReDim myFontNames(myInCopy.Fonts.Count - 1)
	For myCounter = 1 To myInCopy.Fonts.Count
		Set myFont = myInCopy.Fonts.Item(myCounter)
		myFontNames(myCounter - 1) = myFont.Name
	Next
	Set myDialog = myInCopy.Dialogs.Add
	myDialog.Name = "Fonts"
	With myDialog
		With .DialogColumns.Add
			With .DialogRows.Add
				With .DialogColumns.Add
					With .StaticTexts.Add
						.StaticLabel = "Font Name:"
					End With
				End With
				With .DialogColumns.Add
					Set myFontDropdown = .Dropdowns.Add
					myFontDropdown.StringList = myFontNames
					myFontDropdown.SelectedIndex = 0
				End With
			End With
		End With
	End With
	myResult = myDialog.Show
	If myResult = True Then
		myFontName = myFontNames(myFontDropdown.SelectedIndex)
		myDialog.Destroy
		Rem The font name can be either the name of the font, or the name
		Rem of the font, a tab character, and then the font style of the font.
		Rem In some cases, applying the latter form using the AppliedFont
		Rem property will fail, so the following section splits the string
		Rem and applies the font and font style separately.
		If InStr(myFontName, vbTab) <> 0 Then
			myTemp = Split(myFontName, vbTab)
			myText.AppliedFont = myInCopy.Fonts.Item(myTemp(0))
			myText.FontStyle = myTemp(1)
		Else
			myText.AppliedFont = myInCopy.Fonts.Item(myFontName)
		End If
	Else
		myDialog.Destroy
	End If
End Function
Function myGetFontNames(myInCopy)
	ReDim myFontNames(myInCopy.Fonts.Count - 1)
	For myCounter = 1 To myInCopy.Fonts.Count
		Set myFont = myInCopy.Fonts.Item(myCounter)
		myFontNames(myCounter - 1) = myFont.Name
	Next
	myFontNames = myGetFontNames
End Function
Rem</fragment>