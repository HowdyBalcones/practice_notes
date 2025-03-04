--GetEventInfo.applescript
--An InDesign AppleScript
--
--Provides a generic event handler for the EventListenersOn.applescript
--tutorial script. Displays event info about events.
--<fragment>
tell application "Adobe InDesign 2024"
	if (count events) > 0 then
		my myDisplayEventInfo(event 1)
	else
		repeat with myDocument in documents
			if (count events of myDocument) > 0 then
				my myDisplayEventInfo(event 1 of myDocument)
				exit repeat
			end if
		end repeat
	end if
end tell
on myDisplayEventInfo(myEvent)
	tell application "Adobe InDesign 2024"
		--![Get event info.]
		set myString to "Handling Event: " & (event type of myEvent) & return & return
		--Have to handle the target as a special case when it's a document.
		if class of target of myEvent is document then
			set myString to myString & "Target: Document " & name of target of myEvent & return
		else
			set myString to myString & "Target: " & (target of myEvent) & " " & name of (target of myEvent) & return
		end if
		set myString to myString & "Current: " & ((current target of myEvent) as string) & " " & name of current target of myEvent & return & return
		set myString to myString & "Phase: " & my myGetPhaseName(event phase of myEvent) & return
		set myString to myString & "Bubbles: " & bubbles of myEvent & return
		set myString to myString & "Cancelable: " & cancelable of myEvent & return
		set myString to myString & "Stopped: " & propagation stopped of myEvent & return
		set myString to myString & "Canceled: " & default prevented of myEvent & return
		set myString to myString & "Time: " & time stamp of myEvent & return
		display dialog myString with title "Event Details"
	end tell
	--[Get event info.]
end myDisplayEventInfo
--![Get event info - functions.]
on myGetPhaseName(myEventPhase)
	tell application "Adobe InDesign 2024"
		if myEventPhase is at target then
			set myPhaseName to "At Target"
		else if myEventPhase is bubbling phase then
			set myPhaseName to "Bubbling"
		else if myEventPhase is done then
			set myPhaseName to "Done"
			--Can't use "not dispatching" as an enum
		else
			set myPhaseName to "Not Dispatching"
		end if
	end tell
	return myPhaseName
end myGetPhaseName
--![Get event info - functions.]
