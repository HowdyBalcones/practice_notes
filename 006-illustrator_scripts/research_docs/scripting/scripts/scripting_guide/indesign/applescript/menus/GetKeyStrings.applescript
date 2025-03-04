--GetKeyStrings.applescript
--An InDesign AppleScript
--
--Gets the key string(s) of a specified menu action.
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
		--![Get key strings.]
		set myMenuAction to menu action "Convert to Note"
		set myKeyStrings to find key strings for title of myMenuAction
		if class of myKeyStrings is list then
			repeat with myKeyString in myKeyStrings
				set myString to myKeyString & return
			end repeat
		else
			set myString to myKeyStrings
		end if
		display dialog (myString)
		--![Get key strings.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
