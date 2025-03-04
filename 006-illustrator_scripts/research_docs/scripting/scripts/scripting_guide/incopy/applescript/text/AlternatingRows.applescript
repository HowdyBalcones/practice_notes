--AlternatingRows.applescripttell application "Adobe InCopy 2024"tell application "Adobe InCopy 2024"tell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Shows how to format table rows using alternating rows.
--
my main()
on main()
	my mySetup()
	my mySnippet()
end main
on mySetup()
	tell application "Adobe InCopy 2024"
		set myDocument to make document
		tell myDocument
			--Add colors.
			my myAddColor(myDocument, "DGC1_446a", process, {0, 100, 0, 50})
			my myAddColor(myDocument, "DGC1_446b", process, {100, 0, 50, 0})
			set myStory to story 1 of myDocument
			set myString to "Column 1" & tab & "Column 2" & tab & "Column 3" & return
			set myString to myString & "1a" & tab & "1b" & tab & "1c" & return
			set myString to myString & "2a" & tab & "2b" & tab & "2c" & return
			set myString to myString & "3a" & tab & "3b" & tab & "3c" & return
			set contents of myStory to myString
			tell text 1 of myStory
				convert to table
			end tell
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InCopy 2024"
		set myDocument to document 1
		set myTable to table 1 of story 1 of myDocument
		tell myTable
			--Convert the first row to a header row.
			set row type of row 1 to header row
			--Apply alternating fills to the table.
			set alternating fills to alternating rows
			set start row fill color to swatch "DGC1_446a" of myDocument
			set start row fill tint to 60
			set end row fill color to swatch "DGC1_446b" of myDocument
			set end row fill tint to 50
		end tell
	end tell
end mySnippet
on myAddColor(myDocument, myColorName, myColorModel, myColorValue)
	tell application "Adobe InCopy 2024"
		tell myDocument
			try
				set myColor to color myColorName
			on error
				set myColor to make color
			end try
			set properties of myColor to {name:myColorName, model:myColorModel, color value:myColorValue}
		end tell
	end tell
end myAddColor

