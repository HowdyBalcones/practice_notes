--HeaderAndFooterRows.applescripttell application "Adobe InCopy 2024"tell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Shows how to add header and footer rows to a table.
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
		set myStory to story 1 of myDocument
		set myString to "Head 1" & tab & "Head 2" & tab & "Head 3" & return
		set myString to myString & "1a" & tab & "1b" & tab & "1c" & return
		set myString to myString & "2a" & tab & "2b" & tab & "2c" & return
		set myString to myString & "3a" & tab & "3b" & tab & "3c" & return
		set myString to myString & "Foot 1" & tab & "Foot 2" & tab & "Foot 3" & return
		set contents of myStory to myString
		tell text 1 of myStory
			convert to table
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InCopy 2024"
		tell table 1 of story 1 of document 1
			--Convert the first row to a header row.
			set row type of row 1 to header row
			--Convert the last row to a footer row.
			set row type of row -1 to footer row
		end tell
	end tell
end mySnippet


