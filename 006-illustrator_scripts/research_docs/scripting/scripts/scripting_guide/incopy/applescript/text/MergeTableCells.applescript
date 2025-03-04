--MergeTableCells.applescripttell application "Adobe InCopy 2024"tell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Shows how to merge cells in a table.
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
		set myString to "Table
"
		tell myStory
			set contents to myString
			tell insertion point -1
				set myTable to make table
				set column count of myTable to 4
				set body row count of myTable to 4
			end tell
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InCopy 2024"
		set myDocument to document 1
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
	end tell
end mySnippet


