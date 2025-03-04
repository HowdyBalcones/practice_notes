--TaggedTextImportPreferences.applescript
--An InDesign AppleScript
--
--Sets the tagged text import filter preferences.
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
		--![Tagged text import preferences.]
		tell tagged text import preferences
			set remove text formatting to false
			--Options for style conflict are:
			--publication definition
			--tag file definition
			set style conflict to publication definition
			set use typographers quotes to true
		end tell
		--![Tagged text import preferences.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
