--RemoveAfterSelectionChanged.applescript
--An InDesign AppleScript
--
--remove the event listener added by the AfterSelectionChanged script.
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
		--<fragment>
		set myDocument to make document
		tell myDocument
			remove event listener event type "afterSelectionChanged" handler myDisplaySelectionType
		end tell
		--</fragment>
	end tell
end mySnippet
on myTeardown()
end myTeardown
