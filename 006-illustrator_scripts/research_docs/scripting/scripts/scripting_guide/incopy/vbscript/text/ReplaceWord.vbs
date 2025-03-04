Rem ReplaceWord.vbs
Rem An InCopy VBScript
Rem
Rem Enters text in the default story and then replaces
Rem a word in the story with a different phrase.
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
	Rem Add text to the default story.
	Set myStory = myDocument.Stories.Item(1)
	myStory.Contents = "This is some example text."
	Rem Replace the third word "some" with the phrase
	Rem "a little bit of".
	myStory.Words.Item(3).Contents = "a little bit of"
End Function
Function myTeardown(myInCopy)
End Function

