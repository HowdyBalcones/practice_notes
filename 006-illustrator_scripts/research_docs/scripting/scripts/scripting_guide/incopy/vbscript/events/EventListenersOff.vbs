Rem EventListenersOff.vbs
Rem An InCopy VBScript
Rem
Rem Removes all event listeners from the application.
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
	For myCounter = 1 To myInCopy.EventListeners.Count
		myInCopy.EventListeners.Item(1).Delete
	Next
End Function
Function myTeardown(myInCopy)
End Function

