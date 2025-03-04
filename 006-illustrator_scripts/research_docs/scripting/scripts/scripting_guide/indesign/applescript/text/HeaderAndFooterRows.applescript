--HeaderAndFooterRows.applescript
--An InDesign AppleScript
--
--Shows how to add header and footer rows to a table.
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
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		--![Header and footer rows.]
		--Given a document containing a story that contains a table...
		tell table 1 of story 1 of document 1
			--Convert the first row to a header row.
			set row type of row 1 to header row
			--Convert the last row to a footer row.
			set row type of row -1 to footer row
		end tell
		--![Header and footer rows.]
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
