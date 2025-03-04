Rem GetTrackchange.vbs
Rem An InCopy VBScript
Rem 
Rem Get GetTrackchange from story

Rem

main
Function main()
	Set myInCopy = CreateObject("InCopy.Application.2024")
	mySetup myInCopy
	mySnippet myInCopy
	myTeardown myInCopy
End Function
Function mySetup(myInCopy)
End Function
Function mySnippet(myInCopy)
	Set myDocument = myInCopy.Documents.Item(1)
	Set myStory = myDocument.Stories.Item(1)
	If(myStory.TrackChanges=true ) Then
	    Set myChange = myStory.Changes.Item(1)
	    If(myStory.Changes.Count>1) Then
	        Set myChange0 = myStory.Changes.NextItem(myChange)
	    End If
	End If
End Function
Function myTeardown(myInCopy)
End Function
