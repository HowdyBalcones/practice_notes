--ListIdleTasks.applescript
--An InDesign AppleScript
--
--List all InDesign idle tasks.

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
		--![List idle tasks.]
		set taskCount to count of idle tasks
		if taskCount is 0 then
			display alert "There is no idle task."
		else
			set str to ""
			repeat with i from 1 to taskCount
				set myIdleTask to item i of idle tasks
				tell myIdleTask
					set str to str & "idle task " & id & ": " & name & return
				end tell
			end repeat
			display alert str
		end if
		--![List idle tasks.]
	end tell
end mySnippet

on myTeardown()
end myTeardown
