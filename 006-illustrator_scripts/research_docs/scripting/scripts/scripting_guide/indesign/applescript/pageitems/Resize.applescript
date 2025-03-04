--Resize.applescript
--An InDesign AppleScript
--
--Shows how to use the resize method.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		tell view preferences of myDocument
			set horizontal measurement units to points
			set vertical measurement units to points
		end tell
		tell page 1 of myDocument
			set myRectangle to make rectangle with properties {geometric bounds:{72, 72, 144, 144}, stroke weight:4}
		end tell
		set myTransformationMatrix to make transformation matrix with properties {counterclockwise rotation angle:30}
		tell myRectangle
			transform in pasteboard coordinates from center anchor with matrix myTransformationMatrix
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myRectangle to rectangle 1 of page 1 of document 1
		--![Resize.]
		--Given a reference to a rectangle "myRectangle"...
		set myDuplicate to duplicate myRectangle
		resize myDuplicate in inner coordinates from center anchor by multiplying current dimensions by values {2, 2}
		--![Resize.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
