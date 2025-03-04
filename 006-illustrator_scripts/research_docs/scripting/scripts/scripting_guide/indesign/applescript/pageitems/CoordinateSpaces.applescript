--CoordinateSpaces.applescript
--An InDesign AppleScript
--
--Demonstrates the differences between the different coordinate
--systems (inner, parent, and pasteboard) used as parameters
--for the transform method.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySnippet()
	tell application "Adobe InDesign 2024"
		--![Coordinate spaces.]
		--Given a group containing a rectangle on page 1...
		set myRectangle to rectangle 1 of group 1 of page 1 of document 1
		set myString to "The page contains a group which has been" & return
		set myString to myString & "rotated 45 degrees (counterclockwise)." & return
		set myString to myString & "The rectangle inside the group was" & return
		set myString to myString & "rotated 45 degrees counterclockwise before" & return
		set myString to myString & "it was added to the group." & return & return
		set myString to myString & "Watch as we apply a series of scaling" & return
		set myString to myString & "operations in different coordinate spaces."
		display dialog myString
		set myTransformationMatrix to make transformation matrix with properties {horizontal scale factor:2}
		--Transform the rectangle using inner coordinates.
		transform myRectangle in inner coordinates from center anchor with matrix myTransformationMatrix
		--Select the rectangle and display an alert.
		select myRectangle
		display dialog "Transformed using inner coordinates."
		--Undo the transformation.
		tell document 1 to undo
		--Transform using parent coordinates.
		transform myRectangle in parent coordinates from center anchor with matrix myTransformationMatrix
		select myRectangle
		display dialog "Transformed using parent coordinates."
		tell document 1 to undo
		--Transform using pasteboard coordinates.
		transform myRectangle in pasteboard coordinates from center anchor with matrix myTransformationMatrix
		select myRectangle
		display dialog "Transformed using pasteboard coordinates."
		tell document 1 to undo
		--![Coordinate spaces.]
	end tell
end mySnippet
on mySetup()
	tell application "Adobe InDesign 2024"
		set when scaling of transform preferences to adjust scaling percentage
		set myTransformationMatrix to make transformation matrix with properties {counterclockwise rotation angle:45}
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
				--Rotate the rectangle around its center point.
				transform myRectangle in pasteboard coordinates from center anchor with matrix myTransformationMatrix
				--Add a series of ovals.
				set myOvalA to make oval with properties {geometric bounds:{-84, -84, -60, -60}}
				set myOvalB to make oval with properties {geometric bounds:{84, -84, 60, -60}}
				set myOvalC to make oval with properties {geometric bounds:{-84, 84, -60, 60}}
				set myOvalD to make oval with properties {geometric bounds:{84, 84, 60, 60}}
				--Group the rectangle and the ovals.
				set myGroup to make group with properties {group items:{myRectangle, myOvalA, myOvalB, myOvalC, myOvalD}}
				--Rotate the group.
				transform myGroup in pasteboard coordinates from center anchor with matrix myTransformationMatrix
			end tell
		end tell
	end tell
end mySetup
on myTeardown()
end myTeardown
