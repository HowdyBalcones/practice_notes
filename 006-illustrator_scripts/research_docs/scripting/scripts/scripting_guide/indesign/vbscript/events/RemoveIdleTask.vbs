Rem RemoveIdleTask.vbs
Rem An InDesign VBScript
Rem
Rem Remove InDesign idle task with the specified name.

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
	Rem ![Remove idle task.]
	taskCount = myInDesign.IdleTasks.Count
	If taskCount = 0 Then
		MsgBox("There is no idle task.")
    Else
		myIdleTaskName = "my_idle_task"
		For Each myIdleTask In myInDesign.IdleTasks
			If myIdleTask.Name = myIdleTaskName Then
				myIdleTask.Delete()
			End If
			MsgBox("Idle task " & myIdleTaskName & " removed.")
		Next
	End If
	Rem ![Remove idle task.]
End Function

Function myTeardown(myInDesign)
End Function
