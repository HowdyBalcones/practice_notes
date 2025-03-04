Rem Rejectchange.vbs
Rem An InCopy VBScript
Rem 
Rem reject trackchange

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
	Rem ![Reject tracked change.]
	Set myDocument = myInDesign.Documents.Item(1)
	Set myStory = myDocument.Stories.Item(1)
	Set myChange = myStory.Changes.Item(1)
	myChange.Reject
	Rem ![Reject tracked change.]
End Function
Function myTeardown(myInDesign)
End Function