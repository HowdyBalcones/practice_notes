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
  Set myNote = myInsertionPoint.Notes.Add
  myNote.Texts.Item(1).Contents = "This is a Note."
  Set myNote2 = myInsertionPoint.Notes.Add
  myNote2.Texts.Item(1).Contents = "This is a Note."
End Function

Function mySnippet(myInCopy)
  Set myInCopy = CreateObject("InCopy.Application.2024")
  Set myDocument = myIncopy.Documents.Item(1)
  Set myStory = myDocument.Stories.Item(1)
  Set myNote =  myStory.Notes.previousItem(myStory.Notes.Item(2))
  myNote.Texts.Item(1).Contents = "This is the prev note."
  
End Function

Function myTeardown(myInCopy)
End Function

