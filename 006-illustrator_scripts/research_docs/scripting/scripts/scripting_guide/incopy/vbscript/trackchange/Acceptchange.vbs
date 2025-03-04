Rem Acceptchange.vbs
Rem An InCopy VBScript
Rem 
Rem Accept Trackchange

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
	Set myChange = myStory.Changes.Item(1)
	myChange.Accept
		
End Function
Function myTeardown(myInCopy)
End Function