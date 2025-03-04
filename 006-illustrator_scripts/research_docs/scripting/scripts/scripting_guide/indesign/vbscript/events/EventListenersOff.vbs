Rem EventListenersOff.vbs
Rem An InDesign VBScript
Rem
Rem Removes all event listeners from the application and all open documents.
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
	Rem ![Event listeners off.]
	For myCounter = 1 To myInDesign.EventListeners.Count
		myInDesign.EventListeners.Item(1).Delete
	Next
	For myCounter = 1 To myInDesign.Documents.Count
		For myDocumentEventCounter = 1 To myInDesign.Documents.Item(myCounter).EventListeners.Count
			myInDesign.Documents.Item(myCounter).EventListeners.Item(1).Delete
		Next
	Next
	Rem ![Event listeners off.]
End Function
Function myTeardown(myInDesign)
End Function