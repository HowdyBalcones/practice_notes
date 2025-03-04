Rem NestedStyles.vbs
Rem An InCopy VBScript
Rem
Rem Shows how to create a paragraph style containing a nested style.
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
	Rem Create a color
	Set myRedColor = myAddColor(myDocument, "Red", idColorModel.idProcess, Array(0, 100, 100, 0))
	Rem Create  a character style
	Set myCharacterStyle = myAddStyle(myDocument, "myCharacterStyle", 1)
	myCharacterStyle.FillColor = myRedColor
	Rem Create  a paragraph style
	Set myParagraphStyle = myAddStyle(myDocument, "myParagraphStyle", 2)
	Rem Create a text frame on page 1.
	Set myStory = myDocument.Stories.Item(1)
	Rem Fill the text frame with placeholder text.
	myStory.TextContainers.Item(1).Contents = idTextFrameContents.idPlaceholderText
End Function
Function mySnippet(myInCopy)
	Rem<fragment>
	Set myDocument = myInCopy.Documents.Item(1)
	Set myParagraphStyle = myDocument.ParagraphStyles.Item("myParagraphStyle")
	Rem At this point, the variable myParagraphStyle contains a reference to a paragraph
	Rem style object, which you can now use to specify formatting.
	Set myNestedStyle = myParagraphStyle.NestedStyles.Add
	myNestedStyle.AppliedCharacterStyle = myDocument.CharacterStyles.Item("myCharacterStyle")
	myNestedStyle.Delimiter = "."
	myNestedStyle.Inclusive = True
	myNestedStyle.Repetition = 1
	Rem Note that the story object does not have the ApplyParagraphStyle method.)
	Set myStory = myDocument.Stories.Item(1)
	myStory.Texts.Item(1).ApplyParagraphStyle myParagraphStyle, True
	Rem</fragment>
End Function
Function myTeardown(myInCopy)
End Function
Function myAddColor(myDocument, myColorName, myColorModel, myColorValue)
    On Error Resume Next
    Set myColor = myDocument.Colors.Item(myColorName)
    If Err.Number <> 0 Then
        Set myColor = myDocument.Colors.Add
        myColor.Name = myColorName
    End If
    Err.Clear
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
            End If
            Err.Clear
            On Error GoTo 0
        Case 2:
            Set myStyle = myDocument.ParagraphStyles.Item(myStyleName)
            If Err.Number <> 0 Then
                Set myStyle = myDocument.ParagraphStyles.Add
                myStyle.Name = myStyleName
            End If
            Err.Clear
            On Error GoTo 0
        Case 3:
            Set myStyle = myDocument.ObjectStyles.Item(myStyleName)
            If Err.Number <> 0 Then
                Set myStyle = myDocument.ObjectStyles.Add
                myStyle.Name = myStyleName
            End If
            Err.Clear
            On Error GoTo 0
    End Select
    Set myAddStyle = myStyle
End Function