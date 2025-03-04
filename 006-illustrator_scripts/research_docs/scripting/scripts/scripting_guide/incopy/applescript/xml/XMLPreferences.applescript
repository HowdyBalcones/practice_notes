--XMLPreferences.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Sets tagging preset options.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
end mySetup
on mySnippet()
	tell application "Adobe InCopy 2024"
		set myDocument to make document
		tell myDocument
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
		end tell
	end tell
end mySnippet
on myTeardown()
end myTeardown
