--TextImportPreferences.applescript
--An InDesign AppleScript
--
--Sets the text import filter preferences.
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
		--![Text import preferences.]
		tell text import preferences
			--Options for character set:
			set character set to UTF8
			set convert spaces into tabs to true
			set spaces into tabs count to 3
			--The dictionary property can take many values, such as French, Italian.
			set dictionary to "English: USA"
			--platform options:
			--macintosh
			--pc
			set platform to macintosh
			set strip returns between lines to true
			set strip returns between paragraphs to true
			set use typographers quotes to true
		end tell
		--![Text import preferences.]
	end tell
end mySnippet
to myTeardown()
end myTeardown
