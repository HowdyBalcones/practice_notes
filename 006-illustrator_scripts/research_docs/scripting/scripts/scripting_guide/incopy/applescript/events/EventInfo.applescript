--EventInfo..applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Displays info about an event.
--"evt" is the event that is passed to the handler script.
main(evt)
on main(myEvent)
	tell application "Adobe InCopy 2024"
		set myString to "Current Target: " & name of current target of myEvent & return
		display dialog (myString)
	end tell
end main
