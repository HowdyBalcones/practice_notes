--ExportTextRange.applescript
--An InDesign AppleScript
--
--Creates a story in an example document and then exports 
--some of the text to a text file.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		set myPage to page 1 of myDocument
		tell myPage
			set myTextFrame to make text frame with properties {geometric bounds:my myGetBounds(myDocument, myPage), contents:placeholder text}
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		--![Export text range.]
		--Given a document with a text frame on page 1...
		set myTextFrame to text frame 1 of page 1 of active document
		set myStory to parent story of myTextFrame
		set myStartCharacter to index of character 1 of paragraph 1 of myStory
		set myEndCharacter to the index of last character of paragraph 1 of myStory
		set myText to object reference of text from character myStartCharacter to character myEndCharacter of myStory
		--Export the text range. You'll have to fill in a valid file path on your system.
		tell myText to export to "Macintosh HD:scripting:test.txt" format text type
		--![Export text range.]
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
