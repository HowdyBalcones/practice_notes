--RemoveEventListener.applescript
--An InDesign AppleScript
--
--Removes the event listener created by the AddEventListener script.
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
		--![Remove event listener.]
		--You'll have to fill in your own file path.
		remove event listener event type "afterNew" handler myMessage
		--![Remove event listener.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
