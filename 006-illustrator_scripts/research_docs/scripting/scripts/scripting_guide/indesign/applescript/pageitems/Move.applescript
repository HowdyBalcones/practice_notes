--Move.applescript
--An InDesign AppleScript
--
--Shows how to use the move method.
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
			set horizontal measurement units of view preferences to points
			set vertical measurement units of view preferences to points
			set ruler origin of view preferences to page origin
			set myPage to page 1
			tell page 1
				set myRectangle to make rectangle
				set geometric bounds of myRectangle to {72, 72, 144, 144}
			end tell
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		set myRectangle to rectangle 1 of page 1 of myDocument
		--![Move page items.]
		--Given a reference to a rectangle "myRectangle"...
		--Move the rectangle to the location {12, 12}.
		--Absolute move:
		tell myRectangle to move to {12, 12}
		--Move the rectangle *by* 12 points horizontally, 12 points vertically.
		--Relative move (note empty first parameter):
		tell myRectangle to move by {12, 12}
		--Move the rectangle to another page (rectangle appears at (0,0).
		tell myDocument
			set myPage to make page
		end tell
		tell myRectangle to move to myPage
		--To move a page item to another document, use the Duplicate method.
		--![Move page items.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
