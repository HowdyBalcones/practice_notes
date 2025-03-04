--TaggedTextExportPreferences.applescript
--An InDesign AppleScript
--
--Sets the tagged text export filter preferences.
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
		--![Tagged text export preferences.]
		tell tagged text export preferences
			--Options for character set:
			--ansi
			--ascii
			--gb18030
			--ksc5601
			--shiftJIS
			--unicode
			set character set to unicode
			--tag form options:
			--abbreviated
			--verbose
			set tag form to verbose
		end tell
		--![Tagged text export preferences.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
