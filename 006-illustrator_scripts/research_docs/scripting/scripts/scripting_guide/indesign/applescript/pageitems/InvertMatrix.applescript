--InvertMatrix.applescript
--An InDesign AppleScript
--
--Shows how to use the invert matrix method.
main()
on main()
	my mySetup()
	my mySnippet()
	my myTeardown()
end main
on mySnippet()
	tell application "Adobe InDesign 2024"
		--![Invert matrix.]
		--Given a rectangle on page 1...
		set myRectangle to rectangle 1 of page 1 of document 1
		set myTransformationMatrix to make transformation matrix with properties {counterclockwise rotation angle:30, horizontal translation:12, vertical translation:12}
		transform myRectangle in pasteboard coordinates from center anchor with matrix myTransformationMatrix
		set myNewRectangle to duplicate myRectangle
		--Move the duplicated rectangle to the location of the original 
		--rectangle by inverting, then applying the transformation matrix.
		set myTransformationMatrix to invert matrix myTransformationMatrix
		transform myNewRectangle in pasteboard coordinates from center anchor with matrix myTransformationMatrix
		--![Invert matrix.]
	end tell
end mySnippet
on mySetup()
	tell application "Adobe InDesign 2024"
		set when scaling of transform preferences to adjust scaling percentage
		set myDocument to make document
		set when scaling of transform preferences to adjust scaling percentage
		set horizontal measurement units of view preferences of myDocument to points
		set vertical measurement units of view preferences of myDocument to points
		set zero point of myDocument to {108, 108}
		tell page 1 of myDocument
			set myRectangle to make rectangle with properties {geometric bounds:{72, 72, 144, 144}}
		end tell
	end tell
end mySetup
on myTeardown()
end myTeardown
