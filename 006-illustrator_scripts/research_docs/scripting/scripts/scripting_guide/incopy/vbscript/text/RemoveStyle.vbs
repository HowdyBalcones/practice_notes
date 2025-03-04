Rem RemoveStyle.vbs
Rem An InCopy VBScript
Rem
Rem Shows how to remove a paragraph style.
Rem
main
Function main()
	Set myInCopy = CreateObject("InCopy.Application.2024")
	mySetup myInCopy
	mySnippet myInCopy
	myTeardown myInCopy
End Function
Function mySetup(myInCopy)
	Rem Create an example document.
	Set myDocument = myInCopy.Documents.Add
	Rem Create two paragraph styles and a color.
	Set myColor = myAddColor(myDocument, "Red", idColorModel.idProcess, Array(0, 100, 100, 0))
	Set myParagraphStyleA = myAddStyle(myDocument, "myParagraphStyleA", 2)
	Set myParagraphStyleB = myAddStyle(myDocument, "myParagraphStyleB", 2)
	myParagraphStyleB.FillColor = myColor
	Set myStory = myDocument.Stories.Item(1)
	Rem Fill the text frame with example text.
	myStory.TextContainers.Item(1).Contents = idTextFrameContents.idPlaceholderText
	For myCounter = 1 To 6
		myStory.Paragraphs.AnyItem.ApplyParagraphStyle myParagraphStyleA, True
	Next
End Function
Function mySnippet(myInCopy)
	Set myDocument = myInCopy.Documents.Item(1)
	Set myParagraphStyleA = myDocument.ParagraphStyles.Item("myParagraphStyleA")
	Rem Delete the paragraph style myParagraphStyleA and replace with myParagraphStyleB.
	myParagraphStyleA.Delete myDocument.ParagraphStyles.Item("myParagraphStyleB")
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