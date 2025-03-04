--OnIdle.applescript
--An InDesign AppleScript
--
--Creates an event listener that will run when InDesign is idle.

main()

on main()
	mySetup()
	mySnippet()
	myTeardown()
end main

on mySetup()
end mySetup

on mySnippet()
	tell application "Adobe InDesign 2024"
		--![On idle.]
		set myIdleTaskName to "my_idle_task"
		set myIdleTask to make idle task with properties {name:myIdleTaskName, sleep:10000}
		tell myIdleTask
			--You need to fill in your own file path.
			set fileName to "Macintosh HD:scripting:OnIdleEventHandler.applescript"
			set onIdleEventListener to make event listener with properties {event type:"onIdle", handler:fileName, captures:false}
			display alert "Created idle task " & name & "; added event listener on " & event type of onIdleEventListener
		end tell
		--![On idle.]
	end tell
end mySnippet

on myTeardown()
end myTeardown
