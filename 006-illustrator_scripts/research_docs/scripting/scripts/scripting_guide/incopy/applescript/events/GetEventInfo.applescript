--GetEventInfo.appleScripttell application "Adobe InCopy 2024"tell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Displays information about an event object, called from an event listener.
--"evt" is the event object passed to this script.
main(evt)
on main(myEvent)
	tell application "Adobe InCopy 2024"
		set myString to "Handling Event: " & event type of myEvent & return
		set myString to myString & "Target: " & name of target of myEvent & return
		set myString to myString & "Current: " & name of current target of myEvent & return
		set myString to myString & "Phase: " & my myGetPhaseName(event phase of myEvent) & return
		set myString to myString & "Captures: " & captures of myEvent & return
		set myString to myString & "Bubbles: " & bubbles of myEvent & return
		set myString to myString & "Cancelable: " & cancelable of myEvent & return
		set myString to myString & "Stopped: " & propagation stopped of myEvent & return
		set myString to myString & "Canceled: " & default prevented of myEvent & return
		set myString to myString & "Time: " & time stamp of myEvent & return
		display dialog (myString)
	end tell
end main
--Function returns a string corresponding to the event phase.
on myGetPhaseName(myEventPhase)
	tell application "Adobe InCopy 2024"
		if myEventPhase is at target then
			set myString to "At Target"
		else if myEventPhase is bubbling phase then
			set myString to "Bubbling"
		else if myEventPhase is capturing then
			set myString to "Capturing"
		else if myEventPhase is done then
			set myString to "Done"
		else if myEventPhase is not dispatching then
			set myString to "Not Dispatching"
		else
			set myString to "Unknown Phase"
		end if
		return myString
	end tell
end myGetPhaseName

