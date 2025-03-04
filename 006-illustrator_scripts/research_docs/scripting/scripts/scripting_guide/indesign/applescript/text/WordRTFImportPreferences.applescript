--WordRTFImportPreferences.applescript
--An InDesign AppleScript
--
--Sets the Word/RTF import filter preferences.
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
		--![Word and RTF import preferences.]
		tell word RTF import preferences
			--convert page breaks property can be:
			--column break
			--none
			--page break
			set convert page breaks to none
			--convert tables to property can be:
			--unformatted tabbed text
			--unformatted table
			set convert tables to to Unformatted Table
			set import endnotes to true
			set import footnotes to true
			set import index to true
			set import TOC to true
			set import unused styles to false
			set preserve graphics to false
			set preserve local overrides to false
			set preserve track changes to false
			set remove formatting to false
			--resolve character style clash and resolve paragraph style clash properties can be:
			--resolve clash auto rename
			--resolve clash use existing
			--resolve clash use new
			set resolve character style clash to resolve clash use existing
			set resolve paragraph style clash to resolve clash use existing
			set use typographers quotes to true
		end tell
		--![Word and RTF import preferences.]
	end tell
end mySnippet
on myTeardown()
end myTeardown

