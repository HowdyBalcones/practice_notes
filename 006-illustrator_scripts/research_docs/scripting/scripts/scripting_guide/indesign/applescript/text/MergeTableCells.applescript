--MergeTableCells.applescript
--An InDesign AppleScript
--
--Shows how to merge cells in a table.
my main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		set myString to "Table" & return
		set myPage to active page of active window
		tell myPage
			set myTextFrame to make text frame with properties {geometric bounds:my myGetBounds(myDocument, myPage), contents:myString}
		end tell
		tell insertion point -1 of parent story of myTextFrame
			set myTable to make table
			set column count of myTable to 4
			set body row count of myTable to 4
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Merge table cells.]
		--Given a document "myDocument" containing a story...
		tell story 1 of myDocument
			tell table 1
				--Merge all of the cells in the first column.
				merge cell 1 of column 1 with cell -1 of column 1
				--Convert column 2 into 2 cells (rather than 4).
				merge cell 3 of column 2 with cell -1 of column 2
				merge cell 1 of column 2 with cell 2 of column 2
				--Merge the last two cells in row 1.
				merge cell -2 of row 1 with cell -1 of row 1
				--Merge the last two cells in row 3.
				merge cell -2 of row 3 with cell -1 of row 3
			end tell
		end tell
		--![Merge table cells.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
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
