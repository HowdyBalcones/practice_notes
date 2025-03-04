Rem ReplaceText.vbs
Rem An InCopy VBScript
Rem
Rem Enters text in the default story, and then replaces
Rem the text in the second paragraph.
main
Function main()
	Set myInCopy = CreateObject("InCopy.Application.2024")
	mySetup myInCopy
	mySnippet myInCopy
	myTeardown myInCopy
End Function
Function mySetup(myInCopy)
	Set myDocument = myInCopy.Documents.Add
End Function
Function mySnippet(myInCopy)
	Set myDocument = myInCopy.Documents.Item(1)
	Set myStory = myDocument.Stories.Item(1)
	myStory.Contents = "Paragraph 1." & vbCr & "Paragraph 2." & vbCr & "Paragraph 3." & vbCr
	Rem Replace the text in the second paragraph without replacing
	Rem the return character at the end of the paragraph. To do this,
	Rem we'll use the ItemByRange method.
	Set myStartCharacter = myStory.Paragraphs.Item(2).Characters.Item(1)
	Set myEndCharacter = myStory.Paragraphs.Item(2).Characters.Item(-2)
	Set myText = myStory.Texts.ItemByRange(myStartCharacter, myEndCharacter).Item(1)
	myText.Contents = "This text replaces the text in paragraph 2."
End Function
Function myTeardown(myInCopy)
End Function

