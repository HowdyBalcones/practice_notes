--TransformationOrigin.applescript
--An InDesign AppleScript
--
--Shows how to set the center of transformation.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySnippet()
	tell application "Adobe InDesign 2024"
		--![Transformation origin.]
		--Given a rectangle on page 1...
		set myRectangle to rectangle 1 of document 1
		set myString to "Watch as we rotate the rectangle using different anchor points," & return
		set myString to myString & "bounds types, and coordinate spaces." & return & return
		set myString to myString & "You might have to drag the alert aside to" & return
		set myString to myString & "see the effect of the transformation."
		set myNewRectangle to duplicate myRectangle
		set myTransformationMatrix to make transformation matrix with properties {counterclockwise rotation angle:30}
		--Rotate around the duplicated rectangle's center point.
		transform myNewRectangle in pasteboard coordinates from center anchor with matrix myTransformationMatrix
		--Select the rectangle and display an alert.
		select myNewRectangle
		display dialog "Rotated around center anchor."
		--Undo the transformation.
		tell document 1 to undo
		--Rotate the rectangle around the ruler location [-100, -100]. Note that the anchor point specified here specifes the page
		--containing the point--*not* that transformation point itself. The transformation gets the ruler coordinate [-100, -100] based
		--on that page. Setting the considerRulerUnits parameter to true makes certain that the transformation uses the current
		--ruler units.
		transform myNewRectangle in pasteboard coordinates from {{-100, -100}, top left anchor} with matrix myTransformationMatrix with considering ruler units
		--Move the page guides to reflect the transformation point.
		tell guide 1 of page 1 of document 1 to set location to -100
		tell guide 2 of page 1 of document 1 to set location to -100
		--Select the rectangle and display an alert.
		select myNewRectangle
		display dialog "Rotated around -100x, -100y."
		--Undo the transformation and the guide moves.
		tell document 1 to undo
		tell document 1 to undo
		tell document 1 to undo
		--![Transformation origin.]
	end tell
end mySnippet
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		tell myDocument
			set horizontal measurement units of view preferences to points
			set vertical measurement units of view preferences to points
			set myPageHeight to page height of document preferences
			set myPageWidth to page width of document preferences
			set myPageXCenter to myPageWidth / 2
			set myPageYCenter to myPageHeight / 2
			set zero point to {myPageXCenter, myPageYCenter}
			tell page 1
				make guide with properties {orientation:horizontal, location:0}
				make guide with properties {orientation:vertical, location:0}
				--Create a rectangle.
				set myRectangle to make rectangle with properties {geometric bounds:{-72, -72, 72, 72}}
				set stroke weight of myRectangle to 1
				set stroke color of myRectangle to swatch "Black" of myDocument
			end tell
		end tell
	end tell
end mySetup
on myTeardown()
end myTeardown
