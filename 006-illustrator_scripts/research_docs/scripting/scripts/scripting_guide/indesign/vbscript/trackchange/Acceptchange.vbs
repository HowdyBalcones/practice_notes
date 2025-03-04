Rem Acceptchange.vbs
Rem An InCopy VBScript
Rem 
Rem Accept Trackchange

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
	Rem ![Accept tracked change.]
	Set myDocument = myInDesign.Documents.Item(1)
	Set myStory = myDocument.Stories.Item(1)
	Set myChange = myStory.Changes.Item(1)
	myChange.Accept
	Rem ![Accept tracked change.]
End Function
Function myTeardown(myInDesign)
End Function