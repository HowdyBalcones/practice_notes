--RotateMatrix.applescript
--An InDesign AppleScript
--
--Shows how to use the rotateMatrix method.
main()
on main()
	my mySetup()
	my mySnippet()
	my myTeardown()
end main
on mySnippet()
	tell application "Adobe InDesign 2024"
		--![Rotate matrix.]
		--Given a rectangle on page 1...
		set myRectangle to rectangle 1 of page 1 of document 1
		set myTransformationMatrix to make transformation matrix
		--rotate matrix can take the following parameters: byAngle, byCosine, bySine;
		--The following statements are equivalent (0.25881904510252 is the sine of 15 degrees, 0.96592582628907 is the cosine).
		set myTransformationMatrix to rotate matrix myTransformationMatrix by angle 15
		set myTransformationMatrix to rotate matrix myTransformationMatrix by cosine 0.965925826289
		set myTransformationMatrix to rotate matrix myTransformationMatrix by sine 0.258819045103
		--Rotate the rectangle by the rotated matrix--45 degrees.
		transform myRectangle in pasteboard coordinates from center anchor with matrix myTransformationMatrix
		--![Rotate matrix.]
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
