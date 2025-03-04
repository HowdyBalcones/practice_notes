--XMLPreferences.applescript
--An InDesign AppleScript
--
--Sets XML preferences.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to active document
		tell myDocument
			--![XML preferences.]
			tell XML preferences
				set default cell tag color to blue
				set default cell tag name to "cell"
				set default image tag color to brick red
				set default image tag name to "image"
				set default story tag color to charcoal
				set default story tag name to "text"
				set default table tag color to cute teal
				set default table tag name to "table"
			end tell
			--![XML preferences.]
		end tell
	end tell
end mySnippet
on myTeardown()
end myTeardown
