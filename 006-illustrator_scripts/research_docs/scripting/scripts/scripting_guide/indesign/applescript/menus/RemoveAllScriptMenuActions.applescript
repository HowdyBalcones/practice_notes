--RemoveAllScriptMenuActions.applescript
--An InDesign AppleScript
--
--Removes all of the current script menu actions.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
end mySetup
on mySnippet()
	--![Remove all script menu actions.]
	tell application "Adobe InDesign 2024"
		tell every script menu action to delete
	end tell
	--![Remove all script menu actions.]
end mySnippet
on myTeardown()
end myTeardown
