--RemoveAfterSelectionAttributeChanged.applescript
--An InDesign AppleScript
--
--Remove the event listener added by the AfterSelectionAttributeChanged script.
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
			remove event listener event type "afterSelectionAttributeChanged" handler myCheckForRegistration
		end tell
		--</fragment>
	end tell
end mySnippet
on myTeardown()
end myTeardown
