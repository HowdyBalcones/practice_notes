--TranslateKeyString.applescript
--An InDesign AppleScript
--
--Displays the localized string corresponding to a key string (the
--locale-independent version of an object name).
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
		--![Translate key string.]
		--Enter the key string you want to translate in the following line.
		set myString to translate key string for "$ID/NotesMenu_ConvertToNote"
		display dialog (myString)
		--![Translate key string.]
	end tell
end mySnippet
on myTeardown()
end myTeardown

