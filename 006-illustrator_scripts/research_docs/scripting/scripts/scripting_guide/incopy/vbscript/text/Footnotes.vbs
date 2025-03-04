Rem Footnotes.vbs
Rem An InCopy VBScript
Rem
Rem Shows how to add footnotes.
Rem
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
	Set myTextFrame = myStory.TextContainers.Item(1)
	myTextFrame.Contents = idTextFrameContents.idPlaceholderText
End Function
Function mySnippet(myInCopy)
	Set myDocument = myInCopy.Documents.Item(1)
	With myDocument.FootnoteOptions
		.SeparatorText = vbTab
		.MarkerPositioning = idFootnoteMarkerPositioning.idSuperscriptMarker
	End With
	Set myStory = myDocument.Stories.Item(1)
	Rem Add four footnotes at random locations in the story.
	For myCounter = 1 To 4
		myRandomNumber = CLng(myGetRandom(1, myStory.Words.Count))
		Set myWord = myStory.Words.Item(myRandomNumber)
		Set myFootnote = myWord.InsertionPoints.Item(-1).Footnotes.Add
		Rem Note: when you create a footnote, it contains text--the footnote marker
		Rem and the separator text (if any). If you try to set the text of the footnote
		Rem by setting the footnote contents, you will delete the marker. Instead, append
		Rem the footnote text, as shown below.
		myFootnote.InsertionPoints.Item(-1).Contents = "This is a footnote."
	Next
End Function
Function myTeardown(myInCopy)
End Function
Rem This function gets a random number in the range myStart to myEnd.
Function myGetRandom(myStart, myEnd)
	Rem Here's how to generate a random number from a given range:
	Rem Int((upperbound - lowerbound + 1) * Rnd + lowerbound)
	myGetRandom = (myEnd - (myStart + 1)) * Rnd + myStart
End Function
