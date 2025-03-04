Rem CopyUnformattedText.vbs
Rem An InCopy VBScript
Rem
Rem Shows how to remove formatting from text as you 
Rem move it to other locations in a document.
main
Function main()
	Set myInCopy = CreateObject("InCopy.Application.2024")
	mySetup myInCopy
	mySnippet myInCopy
	myTeardown myInCopy
End Function
Function mySetup(myInCopy)
	Set myDocument = myInCopy.Documents.Add
	set myStory = myDocument.stories.item(1)
	myStory.contents = "This is a formatted string." & vbcr & "Text pasted after this text will retain its formatting." & vbcr & vbcr & "Text moved to the following line will take on the formatting of the insertion point." & vbcr & "Italic: "
	Rem Apply formatting to the first paragraph.
	myStory.Paragraphs.Item(1).FontStyle = "Bold"
	Rem Apply formatting to the last paragraph.
	myStory.Paragraphs.Item(-1).FontStyle = "Italic"
End Function
Function mySnippet(myInCopy)
	Rem <fragment>
	Set myStory = myInCopy.Documents.Item(1).Stories.Item(1)
	Rem Copy from one location to another using a simple copy.
	myInCopy.Select myStory.Paragraphs.Item(1).Words.Item(1)
	myInCopy.Copy
	myInCopy.Select myStory.Paragraphs.Item(2).InsertionPoints.Item(-1)
	myInCopy.Paste
	Rem Copy the unformatted string from the first word to the end of the story
	Rem by getting and setting the contents of text objects. Note that this doesn't 
	Rem really copy the text; it replicates the text string from one text location
	Rem to another.
	myStory.InsertionPoints.Item(-1).Contents = myStory.Paragraphs.Item(1).Words.Item(1).contents
End Function	
Function myTeardown(myInCopy)
End Function