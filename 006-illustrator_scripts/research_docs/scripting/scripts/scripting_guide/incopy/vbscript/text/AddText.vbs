Rem AddText.vbs
Rem An InCopy VBScript
Rem 
Rem Creates a text frame in an example document,
Rem enters text in the text frame, and then adds
Rem text at the end of the text frame.
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
	Rem<fragment>
	Rem Add text to the default story.
	Set myStory = myDocument.Stories.Item(1)
	myStory.Contents = "This is the first paragraph of example text."
	Rem To add more text to the story, we'll use the last insertion point
	Rem in the story. ("vbCr" is a return character in VBScript.)
	Set myInsertionPoint = myStory.InsertionPoints.Item(-1)
	myInsertionPoint.Contents = vbCr & "This is the second paragraph."
	Rem</fragment>
End Function
Function myTeardown(myInCopy)
End Function