--RemoveIdleTask.applescript
--An InDesign AppleScript
--
--Remove InDesign idle task with the specified name.

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
		--![Remove idle task.]
		set taskCount to count of idle tasks
		if taskCount is 0 then
			display alert "There is no idle task."
		else
			set myIdleTaskName to "my_idle_task"
			repeat with i from taskCount to 1 by -1
				set myIdleTask to item i of idle tasks
				if name of myIdleTask is myIdleTaskName then
					delete myIdleTask
				end if
			end repeat
			display alert "Idle task " & myIdleTaskName & " removed."
		end if
		--![Remove idle task.]
	end tell
end mySnippet

on myTeardown()
end myTeardown
