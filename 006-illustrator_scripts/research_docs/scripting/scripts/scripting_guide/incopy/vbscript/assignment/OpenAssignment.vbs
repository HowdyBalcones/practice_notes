Rem OpenAssignment.vbs
Rem An InCopy VBScript
Rem 
Rem Open an InCopy dcoument

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
  Set myDocument = myInCopy.Open("c:\a.icma")

  Set myAssignement = myDocument.Assignments.Item(1)
End Function
Function myTeardown(myInCopy)
End Function



