Rem OnIdle.vbs
Rem An InDesign VBScript
Rem
Rem Creates an event listener that will run when InDesign is idle.

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
	Rem ![On idle.]
	Set myIdleTask = myInDesign.IdleTasks.Add()
	myIdleTask.Name = "my_idle_task"
	myIdleTask.Sleep = 10000
	Rem You need to fill in your own file path.
	fileName = "C:\scripting\OnIdleEventHandler.vbs"
	Set onIdleEventListener = myIdleTask.AddEventListener("onIdle", fileName, False)
	MsgBox("Created idle task " & myIdleTask.Name & "; added event listener on " & onIdleEventListener.EventType)
	Rem ![On idle.]
	
End Function

Function myTeardown(myInDesign)
End Function
