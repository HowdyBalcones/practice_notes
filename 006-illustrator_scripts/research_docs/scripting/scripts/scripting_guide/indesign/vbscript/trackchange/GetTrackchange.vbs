Rem GetTrackchange.vbs
Rem An InCopy VBScript
Rem 
Rem Get GetTrackchange from story

Rem

main
Function main()
	Set myInDesign = CreateObject("InDesign.Application.2024")
	mySetup myInDesign
	mySnippet myInDesign
	myTeardown myInDesign
End Function
Function mySetup(myInDesign)
End Function
Function mySnippet(myInDesign)
	Rem ![Navigate tracked changes - nextItem.]
	Set myDocument = myInDesign.Documents.Item(1)
	Set myStory = myDocument.Stories.Item(1)
	If(myStory.TrackChanges=true ) Then
		Set myChange = myStory.Changes.Item(1)
		If(myStory.Changes.Count>1) Then
			Set myChange0 = myStory.Changes.NextItem(myChange)
			End If
	End If
	Rem ![Navigate tracked changes - nextItem.]
End Function
Function mySnippet1(myInDesign)
	Rem ![Navigate tracked changes - previousItem.]
	Set myDocument = myInDesign.Documents.Item(1)
	Set myStory = myDocument.Stories.Item(1)
	If(myStory.TrackChanges=true ) Then
		Set myChange = myStory.Changes.Item(1)
		If(myStory.Changes.Count>1) Then
			Set myChange0 = myStory.Changes.PreviousItem(myChange)
			End If
	End If
	Rem ![Navigate tracked changes - previousItem.]
End Function
Function myTeardown(myInDesign)
End Function
