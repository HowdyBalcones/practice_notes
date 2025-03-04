--TableFormatting.applescript
--An InCopy AppleScript
--
--Shows how to format table cells.
--
my main()
on main()
	my mySetup()
	my mySnippet()
end main
on mySetup()
	tell application "Adobe InCopy 2024"
		--Create an example document.
		set myDocument to make document
		tell myDocument
			--Add colors.
			my myAddColor(myDocument, "DGC1_446a", process, {0, 100, 0, 50})
			my myAddColor(myDocument, "DGC1_446b", process, {100, 0, 50, 0})
			set myStory to story 1 of myDocument
			set myString to ""
			set myString to myString & "Column 1" & tab & "Column 2" & tab & "Column 3" & return
			set myString to myString & "1a" & tab & "1b" & tab & "1c" & return
			set myString to myString & "2a" & tab & "2b" & tab & "2c" & return
			set myString to myString & "3a" & tab & "3b" & tab & "3c" & return
			set contents of myStory to myString
			tell text 1 of story 1
				convert to table
			end tell
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InCopy 2024"
		set myDocument to document 1
		set myTable to table 1 of story 1 of document 1
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
			--Use everyItem to set the formatting of multiple cells at once.
			tell every cell in myTable
				--myTable.cells.everyItem().topEdgeStrokeColor to myDocument.swatches.item("DGC1_446b")
				set top edge stroke color to swatch "DGC1_446b" of myDocument
				--myTable.cells.everyItem().topEdgeStrokeWeight to 1
				set top edge stroke weight to 1
				--myTable.cells.everyItem().bottomEdgeStrokeColor to myDocument.swatches.item("DGC1_446b")
				set bottom edge stroke color to swatch "DGC1_446b" of myDocument
				--myTable.cells.everyItem().bottomEdgeStrokeWeight to 1
				set bottom edge stroke weight to 1
				--When you set a cell stroke to a swatch, make certain that you also set the stroke weight.
				--myTable.cells.everyItem().leftEdgeStrokeColor to myDocument.swatches.item("None")
				set left edge stroke color to swatch "None" of myDocument
				--myTable.cells.everyItem().leftEdgeStrokeWeight to 0
				set left edge stroke weight to 0
				--myTable.cells.everyItem().rightEdgeStrokeColor to myDocument.swatches.item("None")
				set right edge stroke color to swatch "None" of myDocument
				--myTable.cells.everyItem().rightEdgeStrokeWeight to 0
				set right edge stroke weight to 0
			end tell
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
