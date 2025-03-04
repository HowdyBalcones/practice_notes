--TextExportPreferences.applescript
--An InDesign AppleScript
--
--Sets the text export filter preferences.
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
		--![Text export preferences.]
		tell text export preferences
			--Options for character set:
			--UTF8
			--UTF16
			--platform
			set character set to UTF8
			--platform options:
			--macintosh
			--pc
			set platform to macintosh
		end tell
		--![Text export preferences.]
	end tell
end mySnippet
to myTeardown()
end myTeardown
