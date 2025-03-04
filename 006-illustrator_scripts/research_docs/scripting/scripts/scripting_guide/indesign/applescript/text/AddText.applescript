--AddText.applescript
--An InDesign AppleScript
--
--Creates a text frame in an example document, enters
--text in the text frame, and then adds text at the
--end of the text frame.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		tell myDocument
			--Set the measurement units to points
			tell view preferences of myDocument
				set horizontal measurement units to points
				set vertical measurement units to points
				--Set the ruler origin to page origin.
				set ruler origin to page origin
			end tell
			set myPage to page 1
			tell myPage
				make text frame with properties {geometric bounds:my myGetBounds(myDocument, myPage), contents:"This is some example text."}
			end tell
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--<![Add text.]
		--Given a document "myDocument" with a text frame on page 1
		set myTextFrame to text frame 1 of page 1 of myDocument
		--Add text to the end of the text frame. To do this,
		--We'll use the last insertion point in the story.
		set myNewText to "This is a new paragraph of example text."
		tell parent story of myTextFrame
			set contents of insertion point -1 to return & myNewText
		end tell
		--![Add text.]
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
