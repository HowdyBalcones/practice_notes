--TableFormatting.applescript
--An InDesign AppleScript
--
--Shows how to format table cells.
my main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		--Create an example document.
		set myDocument to make document
		tell myDocument
			--Add colors.
			my myAddColor(myDocument, "DGC1_446a", process, {0, 100, 0, 50})
			my myAddColor(myDocument, "DGC1_446b", process, {100, 0, 50, 0})
			set myString to "Head 1" & tab & "Head 2" & tab & "Head 3" & return
			set myString to myString & "1a" & tab & "1b" & tab & "1c" & return
			set myString to myString & "2a" & tab & "2b" & tab & "2c" & return
			set myString to myString & "3a" & tab & "3b" & tab & "3c" & return
			set myString to myString & "Foot 1" & tab & "Foot 2" & tab & "Foot 3" & return
			set myPage to page 1 of myDocument
			tell myPage
				set myTextFrame to make text frame with properties {geometric bounds:my myGetBounds(myDocument, myPage), contents:myString}
			end tell
			set myStory to parent story of myTextFrame
			tell text 1 of myStory
				convert to table
			end tell
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Table formatting.]
		set myTable to table 1 of story 1 of myDocument
		tell myTable
			--Convert the first row to a header row.
			set row type of row 1 to header row
			--Use a reference to a swatch, rather than to a color.
			set fill color of row 1 to swatch "DGC1_446b" of myDocument
			set fill tint of row 1 to 40
			set fill color of row 2 to swatch "DGC1_446a" of myDocument
			set fill tint of row 2 to 40
			set fill color of row 3 to swatch "DGC1_446a" of myDocument
			set fill tint of row 3 to 20
			set fill color of row 4 to swatch "DGC1_446a" of myDocument
			set fill tint of row 4 to 40
			tell every cell in myTable
				set top edge stroke color to swatch "DGC1_446b" of myDocument
				set top edge stroke weight to 1
				set bottom edge stroke color to swatch "DGC1_446b" of myDocument
				set bottom edge stroke weight to 1
				--When you set a cell stroke to a swatch, make certain that you also set the stroke weight.
				set left edge stroke color to swatch "None" of myDocument
				set left edge stroke weight to 0
				set right edge stroke color to swatch "None" of myDocument
				set right edge stroke weight to 0
			end tell
		end tell
		--![Table formatting.]
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
