--OnIdleEventHandler.applescript
--An InDesign AppleScript
--
--A script which will be run when InDesign is idle.

--![On idle event handler.]
--"evt" is the event passed to this script by the event listener.
onIdleEventHandler(evt)
on onIdleEventHandler(myIdleEvent)
	tell application "Adobe InDesign 2024"
		if (count of documents) = 0 then
			set myDoc to make document
			display alert "Created document " & name of myDoc & " in idle task."
			return
		end if
		
		tell item 1 of pages of active document
			if (count of text frames) = 0 then
				make text frame with properties {geometric bounds:["72pt", "72pt", "288pt", "288pt"], contents:"Text frame created in idle task"}
				display alert "Created a text frame in idle task."
				return
			end if
		end tell
		
		--Delete idle task by setting its sleep time to zero.
		set sleep of parent of myIdleEvent to 0
		display alert "Nothing to do. Delete idle task."
	end tell
end onIdleEventHandler
--![On idle event handler.]
