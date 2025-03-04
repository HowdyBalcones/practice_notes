Rem MoveText.vbs
Rem An InCopy VBScript
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
End Function
Function mySnippet(myInCopy)
	Set myDocument = myInCopy.Documents.Item(1)
	Set myStory = myDocument.Stories.Item(1)
	Rem Create a series of paragraphs in the default story.
	myStory.Contents = "WordA" & vbcr & "WordB" & vbcr & "WordC" & vbcr & "WordD" & vbcr
	Rem Move WordC before WordA.
	myStory.Paragraphs.Item(3).Move idLocationOptions.idBefore, myStory.Paragraphs.Item(1)
	Rem Move WordB after WordD (into the same paragraph).
	myStory.Paragraphs.Item(3).Move idLocationOptions.idAfter, myStory.Paragraphs.Item(-1).Words.Item(1)
	Rem Note that moving text removes it from its original location.
End Function
Function myTeardown(myInCopy)
End Function