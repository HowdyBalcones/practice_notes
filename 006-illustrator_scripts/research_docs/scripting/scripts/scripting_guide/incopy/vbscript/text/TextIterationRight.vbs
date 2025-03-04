Rem TextIterationRight.vbs
Rem An InCopy VBScript
Rem
Rem Shows how to iterate through text.
main
Function main()
	Set myInCopy = CreateObject("InCopy.Application.2024")
	mySetup myInCopy
	mySnippet myInCopy
	myTeardown myInCopy
End Function
Function mySetup(myInCopy)
	Set myDocument = myInCopy.Documents.Add
	Set myStory = myDocument.Stories.Item(1)
	myString = "Paragraph 1." & vbCr & "Delete this paragraph." & vbCr & "Paragraph 2." & vbCr & "Paragraph 3." & vbCr & "Paragraph 4." & vbCr & "Paragraph 5." & vbCr & "Delete this paragraph." & vbCr & "Paragraph 6." & vbCr
	myStory.Contents = myString
End Function
Function mySnippet(myInCopy)
	Rem <fragment>
	Rem The following for loop will format all of the paragraphs by iterating
	Rem backwards through the paragraphs in the story.
	Set myDocument = myInCopy.Documents.Item(1)
	Set myStory = myDocument.Stories.Item(1)
	For myParagraphCounter = myStory.Paragraphs.Count To 1 Step -1
		If myStory.Paragraphs.Item(myParagraphCounter).Words.Item(1).contents = "Delete" Then
			myStory.Paragraphs.Item(myParagraphCounter).Delete
		Else
			myStory.Paragraphs.Item(myParagraphCounter).PointSize = 24
		End If
	Next
	Rem </fragment>
End Function
Function myTeardown(myInCopy)
End Function