--ExcelImportPreferences.applescript
--An InDesign AppleScript
--
--Sets the Excel import filter preferences.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
end mySetup
on mySnippet()
	--![Excel import preferences.]
	tell application "Adobe InDesign 2024"
		tell excel import preferences
			--alignment Style property can be:
			--center align
			--left align
			--right align
			--spreadsheet
			set alignment style to spreadsheet
			set decimal places to 4
			set preserve graphics to false
			--Enter the range you want to import as "start cell:end cell".
			set range name to "A1:B16"
			set sheet index to 1
			set sheet name to "pathpoints"
			set show hidden cells to false
			--table formatting property can be:
			--excel formatted table
			--excel unformatted tabbed text
			--excel unformatted table
			set table formatting to excel formatted table
			set use typographers quotes to true
			set view name to ""
		end tell
	end tell
	--![Excel import preferences.]
end mySnippet
to myTeardown()
end myTeardown
