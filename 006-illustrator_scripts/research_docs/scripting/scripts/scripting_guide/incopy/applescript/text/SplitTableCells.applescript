--SplitTableCells.applescript
--An InCopy AppleScript
--
--Shows how to split cells, column, and rows in a table.
--
my main()
on main()
	my mySetup()
	my mySnippet()
end main
on mySetup()
	tell application "Adobe InCopy 2024"
		set myDocument to make document
		set myStory to story 1 of myDocument
		set myString to "Table" & return
		set contents of myStory to myString
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
	tell application "Adobe InCopy 2024"
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
	end tell
end mySnippet
