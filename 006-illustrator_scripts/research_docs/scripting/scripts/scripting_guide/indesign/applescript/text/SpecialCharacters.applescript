--SpecialCharacters.applescript
--An InDesign AppleScript
--
--Shows how to enter special characters in text.
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
			set myTextFrame to make text frame with properties {geometric bounds:my myGetBounds(myDocument, myPage)}
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Insert special characters.]
		--Given a document "myDocument" containing a story...
		set myStory to story 1 of myDocument
		--Entering special characters directly:
		set contents of myStory to "Registered trademark: ?" & return & "Copyright:  �" & return & "Trademark: �" & return
		--Entering special characters by their Unicode glyph ID value:
		set contents of insertion point -1 of myStory to "Not equal to: <2260>" & return
		set contents of insertion point -1 of myStory to "Square root: <221A>" & return
		set contents of insertion point -1 of myStory to "Square root: <00B6>" & return
		--Entering special characters by their enumerations:
		set contents of insertion point -1 of myStory to "Automatic page number marker: "
		set contents of insertion point -1 of myStory to auto page number
		set contents of insertion point -1 of myStory to return & "Section symbol: "
		set contents of insertion point -1 of myStory to section symbol
		set contents of insertion point -1 of myStory to return & "En dash: "
		set contents of insertion point -1 of myStory to En dash
		set contents of insertion point -1 of myStory to return
	end tell
	--![Insert special characters.]
end mySnippet

to myTeardown()
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
