--MultipleEventListeners.applescript
--An InDesign AppleScript
--
--Shows that an event can trigger multiple event listeners.
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
		--![Multiple event listeners.]
		set myDocument to make document
		--You'll have to fill in a valid file path for your system
		make event listener with properties {event type:"beforeImport", handler:my myEventInfoHandler}
		tell myDocument
			make event listener with properties {event type:"beforeImport", handler:my myEventInfoHandler}
		end tell
		--![Multiple event listeners.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
--![Multiple event listeners - functions.]
on myEventInfoHandler()
	tell application "Adobe InDesign 2024"
		set myString to "Current Target: " & name of (current target of evt) & return
		display dialog (myString)
	end tell
end myEventInfoHandler
--![Multiple event listeners - functions.]
