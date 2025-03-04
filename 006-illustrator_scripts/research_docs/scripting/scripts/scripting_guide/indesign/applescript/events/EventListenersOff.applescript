--EventListenersOff.applescript
--An InDesign AppleScript
--
--Turns off all of the event listeners on the application object.
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
		--![Event listeners off.]
		repeat with myCounter from 1 to (count event listeners)
			delete event listener 1
		end repeat
		--![Event listeners off.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
