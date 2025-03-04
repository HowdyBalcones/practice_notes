--RemoveAllIdleTasks.applescript
--An InDesign AppleScript
--
--Remove all InDesign idle tasks.

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
		--![Remove all idle tasks.]
		set taskCount to count of idle tasks
		if taskCount is 0 then
			display alert "There is no idle task."
		else
			repeat with i from taskCount to 1 by -1
				set myIdleTask to item i of idle tasks
				delete myIdleTask
			end repeat
			display alert "" & taskCount & " idle task(s) removed."
		end if
		--![Remove all idle tasks.]
	end tell
end mySnippet

on myTeardown()
end myTeardown

