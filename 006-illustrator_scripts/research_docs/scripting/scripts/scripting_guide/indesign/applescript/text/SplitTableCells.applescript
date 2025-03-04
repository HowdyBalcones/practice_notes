--SplitTableCells.applescript
--An InDesign AppleScript
--
--Shows how to split cells, columns, and rows in a table.
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
		set myStory to parent story of myTextFrame
		tell insertion point -1 of myStory
			set myTable to make table
			set column count of myTable to 1
			set body row count of myTable to 1
		end tell
		set myBounds to geometric bounds of item 1 of text containers of myStory
		set myWidth to (item 4 of myBounds) - (item 2 of myBounds)
		set width of column 1 of myTable to myWidth
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		--![Split table cells.]
		tell table 1 of story 1 of document 1
			split cell 1 using horizontal
			split column 1 using vertical
			split cell 1 using vertical
			split row -1 using horizontal
			split cell -1 using vertical
			--Fill the cells with row:cell labels.
			repeat with myRowCounter from 1 to (count rows)
				set myRow to row myRowCounter
				repeat with myCellCounter from 1 to (count cells of myRow)
					set myString to "Row: " & myRowCounter & " Cell: " & myCellCounter
					set contents of text 1 of cell myCellCounter of row myRowCounter to myString
				end repeat
			end repeat
		end tell
		--![Split table cells.]
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
