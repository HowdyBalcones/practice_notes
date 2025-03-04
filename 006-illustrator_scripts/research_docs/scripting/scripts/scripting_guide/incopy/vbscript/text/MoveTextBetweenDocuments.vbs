Rem MoveTextBetweenDocuments.vbs
Rem An InCopy VBScript
Rem
Rem Moves formatted text from one document to another using import/export.
main
Function main()
	Set myInCopy = CreateObject("InCopy.Application.2024")
	mySetup myInCopy
	mySnippet myInCopy
	myTeardown myInCopy
End Function
Function mySetup(myInCopy)
	Set mySourceDocument = myInCopy.Documents.Add
	Set myStory = mySourceDocument.Stories.Item(1)
	myStory.Contents = "This is the source text." & vbCr & "This text is not the source text."
	myStory.Paragraphs.Item(1).PointSize = 24
End Function
Function mySnippet(myInCopy)
	Rem <fragment>
	Set myDocument = myInCopy.Documents.Item(1)
	Set myStory = myDocument.Stories.Item(1)
	Set mySourceParagraph = myStory.Paragraphs.Item(1)
	Rem Create a target.
	Set myTargetDocument = myInCopy.Documents.Add
	Set myStory = myTargetDocument.Stories.Item(1)
	myStory.Contents = "This is the target text. Insert the source text after this paragraph." & vbCr
	mySourceParagraph.duplicate idLocationOptions.idAfter, myStory.InsertionPoints.Item(-1)
	Rem </fragment>
End Function
Function myTeardown(myInCopy)
End Function