--InsertTextFile.applescript
--An InDesign AppleScript
--
--Places a text file inside a text frame without
--replacing existing text.
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
			set myTextFrame to make text frame with properties {geometric bounds:my myGetBounds(myDocument, myPage), contents:"Inserted text file follows:" & return}
		end tell
	end tell
end mySetup
to mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Insert text file.]
		--Given a document "myDocument" with a text frame on page 1...
		--Place a text file at the end of the text.
		set myTextFrame to text frame 1 of page 1 of myDocument
		tell insertion point -1 of parent story of myTextFrame
			--You'll need to fill in a valid file path for your system.
			place "yukino:test.txt" without showing options
		end tell
		--![Insert text file.]
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
