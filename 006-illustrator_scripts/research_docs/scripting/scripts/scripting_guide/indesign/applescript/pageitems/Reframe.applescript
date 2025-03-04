--Reframe.applescript
--An InDesign AppleScript
--
--Shows how to use the reframe method.
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
		set myTransformationMatrix to make transformation matrix with properties {counterclockwise rotation angle:45}
		tell myRectangle
			transform in pasteboard coordinates from center anchor with matrix myTransformationMatrix
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myRectangle to rectangle 1 of page 1 of document 1
		--![Reframe.]
		--Given a reference to a rectangle "myRectangle"...
		set myDuplicate to duplicate myRectangle
		resolve myDuplicate location top left anchor in inner coordinates without considering ruler units
		set myTopLeft to item 1 of the result
		resolve myDuplicate location bottom right anchor in inner coordinates without considering ruler units
		set myBottomRight to item 1 of the result
		set myWidth to (item 1 of myBottomRight) - (item 1 of myTopLeft)
		tell myDuplicate
			reframe in inner coordinates opposing corners {{(item 1 of myTopLeft) + myWidth, item 2 of myTopLeft}, {(item 1 of myBottomRight) + myWidth, item 2 of myBottomRight}}
		end tell
		--![Reframe.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
