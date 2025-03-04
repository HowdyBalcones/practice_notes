--ExportTextFile.applescript
--An InDesign AppleScript
--
--Creates a story in an example document and then exports the text to a text file.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
	end tell
end mySetup
on mySnippet()
	--![Export text file.]
	tell application "Adobe InDesign 2024"
		set myDocument to active document
		set myPage to page 1 of myDocument
		tell myPage
			set myTextFrame to make text frame with properties {geometric bounds:my myGetBounds(myDocument, myPage), contents:placeholder text}
		end tell
		--Text export method parameters:
		--format as enumeration
		--to alias as string
		--showing options boolean 
		--version comments string 
		--force save boolean 
		--Format parameter can be:
		--InCopy Markup
		--html
		--epub
		--rtf
		--tagged text
		--text type
		--Export the story as text. You'll have to fill in a valid file path on your system.
		tell parent story of myTextFrame
			export to "yukino:test.txt" format text type
		end tell
	end tell
	--![Export text file.]
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
