Rem An InCopy VBScript

main
Function main()
	Set myInCopy = CreateObject("InCopy.Application.2024")
	mySetup myInCopy
	mySnippet myInCopy
	myTeardown myInCopy
End Function

Function mySetup(myInCopy)
  Set myInCopy = CreateObject("InCopy.Application.2024")
  Set myDocument = myIncopy.Documents.Add()
  Set myStory = myDocument.Stories.Item(1)
  Rem We'll use the last insertion pointc in the story.
  Set myInsertionPoint = myStory.insertionPoints.Item(-1)
  myInsertionPoint.Texts.Item(1).Contents = "This is a Note."
End Function

Function mySnippet(myInCopy)
  Set myInCopy = CreateObject("InCopy.Application.2024")
  Set myDocument = myIncopy.Documents.Item(1)
  Set myStory = myDocument.Stories.Item(1)
  myStory.words.Item(1).convertToNote()
  
End Function

Function myTeardown(myInCopy)
End Function

