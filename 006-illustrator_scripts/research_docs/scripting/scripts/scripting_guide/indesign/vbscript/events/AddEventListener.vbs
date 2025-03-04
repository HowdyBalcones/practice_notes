Rem AddEventListener.vbs
Rem An InDesign VBScript
Rem
Rem Creates a simple event listener.
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
	Rem ![Add event listener.]
	myInDesign.AddEventListener "afterNew", GetRef("myDisplayEventType")
	Rem ![Add event listener.]
End Function
Function myTeardown(myInDesign)
End Function
Rem ![Add event listener - functions.]
Function myDisplayEventType(en)
	Rem "myEvent" is the event passed to this function by the event listener.
	MsgBox ("This event is the " & en.EventType & " event.")
	'MsgBox ("This event is the after new event.")
End Function
Rem ![Add event listener - functions.]