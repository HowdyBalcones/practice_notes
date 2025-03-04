Rem GetEventInfo.vbs
Rem An InCopy VBScript
Rem
Rem Displays information about an Event object; called from an EventListener.
main evt
Function main(myEvent)
	myString = "Handling Event: " & myEvent.EventType
	myString = myString & vbCr & vbCr & "Target: " & myEvent.Target & " " & myEvent.Target.Name
	myString = myString & vbCr & "Current: " & myEvent.CurrentTarget & " " & myEvent.CurrentTarget.Name
	myString = myString & vbCr & vbCr & "Phase: " & myGetPhaseName(myEvent.EventPhase)
	myString = myString & vbCr & "Captures: " & myEvent.Captures
	myString = myString & vbCr & "Bubbles: " & myEvent.Bubbles
	myString = myString & vbCr & vbCr & "Cancelable: " & myEvent.Cancelable
	myString = myString & vbCr & "Stopped: " & myEvent.PropagationStopped
	myString = myString & vbCr & "Canceled: " & myEvent.DefaultPrevented
	myString = myString & vbCr & vbCr & "Time: " & myEvent.TimeStamp
	MsgBox myString, vbOKOnly, "Event Details"
end function
Rem Function returns a string corresponding to the event phase enumeration.
Function myGetPhaseName(myEventPhase)
	Select Case myEventPhase
		Case idEventPhases.idAtTarget
			myPhaseName = "At Target"
		Case idEventPhases.idBubblingPhase
			myPhaseName = "Bubbling"
		Case idEventPhases.idCapturingPhase
			myPhaseName = "Capturing"
		Case idEventPhases.idDone
			myPhaseName = "Done"
		Case idEventPhases.idNotDispatching
			myPhaseName = "Not Dispatching"
	end select
	myGetPhaseName = myPhaseName
End Function