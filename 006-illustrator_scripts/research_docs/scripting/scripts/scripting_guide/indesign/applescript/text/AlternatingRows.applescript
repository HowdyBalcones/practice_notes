--AlternatingRows.applescript
--An InDesign AppleScript
--
--Shows how to format table rows using alternating rows.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		tell myDocument
			--Add colors.
			my myAddColor(myDocument, "DGC1_446a", process, {0, 100, 0, 50})
			my myAddColor(myDocument, "DGC1_446b", process, {100, 0, 50, 0})
			--Populate the table.
			set myString to "Head 1" & tab & "Head 2" & tab & "Head 3" & return
			set myString to myString & "1a" & tab & "1b" & tab & "1c" & return
			set myString to myString & "2a" & tab & "2b" & tab & "2c" & return
			set myString to myString & "3a" & tab & "3b" & tab & "3c" & return
			set myString to myString & "4a" & tab & "4b" & tab & "4c" & return
			set myString to myString & "5a" & tab & "5b" & tab & "5c" & return
			set myPage to page 1 of myDocument
			tell myPage
				set myTextFrame to make text frame with properties {geometric bounds:my myGetBounds(myDocument, myPage), contents:myString}
			end tell
			set myStory to parent story of myTextFrame
			tell text 1 of myStory
				convert to table
			end tell
		end tell
		set myTable to table 1 of story 1 of myDocument
		tell myTable
			--Convert the first row to a header row.
			set row type of row 1 to header row
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to active document
		--![Alternating rows.]
		--Given a document "myDocument" containing a story that 
		--contains a table...
		set myTable to table 1 of story 1 of myDocument
		tell myTable
			--Apply alternating fills to the table.
			set alternating fills to alternating rows
			set start row fill color to swatch "DGC1_446a" of myDocument
			set start row fill tint to 60
			set end row fill color to swatch "DGC1_446b" of myDocument
			set end row fill tint to 50
		end tell
		--![Alternating rows.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
on myAddColor(myDocument, myColorName, myColorModel, myColorValue)
	tell application "Adobe InDesign 2024"
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
on myGetBounds(myDocument, myPage)
	tell application "Adobe InDesign 2024"
		tell document preferences of myDocument
			set myPageWidth to page width
			set myPageHeight to page height
		end tell
		tell margin preferences of myPage
			if side of myPage is left hand then
				set myX2 to left
				set myX1 to right
			else
				set myX1 to left
				set myX2 to right
			end if
			set myY1 to top
			set myY2 to bottom
		end tell
		set myX2 to myPageWidth - myX2
		set myY2 to myPageHeight - myY2
		return {myY1, myX1, myY2, myX2}
	end tell
end myGetBounds
