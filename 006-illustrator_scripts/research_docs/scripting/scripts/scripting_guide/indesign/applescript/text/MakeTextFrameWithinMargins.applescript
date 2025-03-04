--MakeTextFrameWithinMargins.applescript
--An InDesign AppleScript
--
--Creates a text frame in an example document
--and sizes the text frame to match the page margins.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		--Set the measurement units to points
		tell view preferences of myDocument
			set horizontal measurement units to points
			set vertical measurement units to points
			--Set the ruler origin to page origin.
			set ruler origin to page origin
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		--![Create a text frame within margins.]
		set myDocument to active document
		--Given a document "myDocument"
		set myPage to page 1 of myDocument
		tell myPage
			set myTextFrame to make text frame
			--Set the bounds of the text frame.
			set geometric bounds of myTextFrame to my myGetBounds(myDocument, myPage)
		end tell
		--![Create a text frame within margins.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
--![Create a text frame within margins - functions.]
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
--![Create a text frame within margins - functions.]
