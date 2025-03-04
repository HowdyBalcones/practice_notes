--Duplicate.applescript
--An InDesign AppleScript
--
--Shows how to use the duplicate method.
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
		--![Duplicate page items.]
		--Given a reference to a rectangle "myRectangle"...
		--Duplicate the rectangle and move the 
		--duplicate to the location (12, 12).
		--Absolute move:
		set myDuplicate to duplicate myRectangle to {12, 12}
		--Duplicate the rectangle and move the duplicate *by* 12
		--points horizontally, 12 points vertically.
		--Relative move:
		set myDuplicate to duplicate myRectangle
		move myDuplicate by {12, 12}
		--Duplicate the rectangle to another page (rectangle appears at (0,0).
		tell myDocument
			set myPage to make page
		end tell
		set myDuplicate to duplicate myRectangle to myPage
		--Duplicate the rectangle to another document.
		set myNewDocument to make document
		set myDuplicate to duplicate myRectangle to page 1 of myNewDocument
		--![Duplicate page items.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
