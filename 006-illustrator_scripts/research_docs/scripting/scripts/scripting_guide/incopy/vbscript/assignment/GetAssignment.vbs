Rem GetAssignment.vbs
Rem An InCopy VBScript
Rem 
Rem Get assignments from doc

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
	Set myAssignement = myDocument.Assignments.Item(1)
End Function
Function myTeardown(myInCopy)
End Function
