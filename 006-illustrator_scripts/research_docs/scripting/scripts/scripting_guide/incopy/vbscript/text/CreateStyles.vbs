Rem CreateStyles.vbs
Rem An InCopy VBScript
Rem
Rem Shows how to create and apply a paragraph style and a character style.
main
Function main()
	Set myInCopy = CreateObject("InCopy.Application.2024")
	mySetup myInCopy
	mySnippet myInCopy
	myTeardown myInCopy
End Function
Function mySetup(myInCopy)
	Set myDocument = myInCopy.Documents.Add
	Rem Create a color for use by one of the paragraph styles we'll create.
	Set myColor = myAddColor(myDocument, "Red", idColorModel.idProcess, Array(0, 100, 100, 0))
	Rem Create a text frame on page 1.
	Set myStory = myDocument.Stories.Item(1)
	Rem Fill the text frame with placeholder text.
	myStory.Contents = "Normal text. Text with a character style applied to it. More normal text."
End Function
Function mySnippet(myInCopy)
	Set myDocument = myInCopy.Documents.Item(1)
	Set myStory = myDocument.Stories.Item(1)
	Rem <fragment>
	Rem Create a character style named "myCharacterStyle" if
	Rem no style by that name already exists.
	Set myCharacterStyle = myAddStyle(myDocument, "myCharacterStyle", 1)
	Rem At this point, the variable myCharacterStyle contains a reference to a character
	Rem style object, which you can now use to specify formatting.
	myCharacterStyle.FillColor = myDocument.Colors.Item("Red")
	Rem Create a paragraph style named "myParagraphStyle" if
	Rem no style by that name already exists.
	Set myParagraphStyle = myAddStyle(myDocument, "myParagraphStyle", 2)
	Rem At this point, the variable myParagraphStyle contains a reference to a paragraph
	Rem style object, which you can now use to specify formatting.
	myStory.Texts.Item(1).ApplyParagraphStyle myParagraphStyle, True
	Set myStartCharacter = myStory.Characters.Item(14)
	Set myEndCharacter = myStory.Characters.Item(55)
	Set myText = myStory.Texts.ItemByRange(myStartCharacter, myEndCharacter)
	myText.Item(1).ApplyCharacterStyle myCharacterStyle
	Rem </fragment>
End Function
Function myTeardown(myInCopy)
End Function
Function myAddColor(myDocument, myColorName, myColorModel, myColorValue)
	On Error Resume Next
	Set myColor = myDocument.Colors.Item(myColorName)
	If Err.Number <> 0 Then
		Set myColor = myDocument.Colors.Add
		myColor.Name = myColorName
		Err.Clear
	End If
	On Error GoTo 0
	myColor.Model = myColorModel
	myColor.ColorValue = myColorValue
	Set myAddColor = myColor
End Function
Function myAddStyle(myDocument, myStyleName, myStyleType)
	On Error Resume Next
	Select Case myStyleType
		Case 1:
			Set myStyle = myDocument.CharacterStyles.Item(myStyleName)
			If Err.Number <> 0 Then
				Set myStyle = myDocument.CharacterStyles.Add
				myStyle.Name = myStyleName
				Err.Clear
			End If
			On Error GoTo 0
		Case 2:
			Set myStyle = myDocument.ParagraphStyles.Item(myStyleName)
			If Err.Number <> 0 Then
				Set myStyle = myDocument.ParagraphStyles.Add
				myStyle.Name = myStyleName
				Err.Clear
			End If
			On Error GoTo 0
		Case 3:
			Set myStyle = myDocument.ObjectStyles.Item(myStyleName)
			If Err.Number <> 0 Then
				Set myStyle = myDocument.ObjectStyles.Add
				myStyle.Name = myStyleName
				Err.Clear
			End If
			On Error GoTo 0
	End Select
	Set myAddStyle = myStyle
End Function