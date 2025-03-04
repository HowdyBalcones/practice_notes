Rem RemoveEventListener.vbs
Rem An InDesign VBScript
Rem
Rem Removes the event listener created by the AddEventListener script.
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
	Rem ![Remove event listener.]
	myResult = myInDesign.RemoveEventListener("afterNew", "myDisplayEventType")
	If myResult = True Then
		MsgBox "Event listener removed."
	Else
		MsgBox "Event listener not removed."
	End If
	Rem ![Remove event listener.]
End Function
Function myTeardown(myInDesign)
End Function