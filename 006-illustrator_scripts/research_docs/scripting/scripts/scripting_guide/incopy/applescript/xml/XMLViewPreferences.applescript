--XMLViewPreferences.applescript
--An InCopy AppleScript
--
--Sets the properties of the XML view preferences object.
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
			tell XML view preferences
				set show attributes to true
				set show structure to true
				set show tagged frames to true
				set show tag markers to true
				set show text snippets to true
			end tell
		end tell
	end tell
end mySnippet
on myTeardown()
end myTeardown
