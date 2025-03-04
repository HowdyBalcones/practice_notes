--AddEventListener.applescript
--An InDesign AppleScript
--
--Registers an event listener on the afterNew event.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
end mySetup
on mySnippet()
	--![Add event listener.]
	tell application "Adobe InDesign 2024"
		set myEventListener to make event listener with properties {event type:"afterNew", handler:my myMessage}
	end tell
	--![Add event listener.]
end mySnippet
on myTeardown()
end myTeardown
on myMessage()
	--![Add event listener - functions.]
	tell application "Adobe InDesign 2024"
		--"evt" is the event passed to this script by the event listener.
		display dialog "This event is the " & event type of evt & " event."
	end tell
	--![Add event listener - functions.]
end myMessage
