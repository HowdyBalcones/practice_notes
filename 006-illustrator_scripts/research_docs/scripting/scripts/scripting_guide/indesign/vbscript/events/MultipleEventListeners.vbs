Rem MultipleEventListeners.vbs
Rem An InDesign VBScript
Rem 
Rem Shows that an event can trigger multiple event listeners.
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
	Rem ![Multiple event listeners.]
	myInDesign.AddEventListener "beforeImport", GetRef("myEventInfo")
	Set myDocument = myInDesign.Documents.Add
	myInDesign.Documents.Item(1).AddEventListener "beforeImport", GetRef("myEventInfo")
	Rem ![Multiple event listeners.]
End Function
Function myTeardown(myInDesign)
End Function
Rem ![Multiple event listeners - functions.]
Function myEventInfo(en)
	myString = "Current Target: " & en.currentTarget.name
	MsgBox(myString)
End Function
Rem ![Multiple event listeners - functions.]