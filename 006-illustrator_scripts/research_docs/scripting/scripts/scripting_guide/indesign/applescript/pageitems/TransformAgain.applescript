--TransformAgain.applescript
--An InDesign AppleScript
--
--Demonstrates the use of the transform again method(s).
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myPage to page 1 of document 1
		--![Transform again.]
		--Given a rectangle on page 1...
		set myRectangle to rectangle 1 of myPage
		set myBounds to geometric bounds of myRectangle
		set myX1 to item 2 of myBounds
		set myY1 to item 1 of myBounds
		tell myPage
			set myRectangleA to make rectangle with properties {geometric bounds:{myY1 - 12, myX1 - 12, myY1 + 12, myX1 + 12}}
		end tell
		set myTransformationMatrix to make transformation matrix with properties {counterclockwise rotation angle:45}
		transform myRectangleA in pasteboard coordinates from center anchor with matrix myTransformationMatrix
		set myRectangleB to duplicate myRectangleA
		transform myRectangleB in pasteboard coordinates from {{0, 0}, top left anchor} with matrix myTransformationMatrix with considering ruler units
		set myRectangleC to duplicate myRectangleB
		set myResult to transform again myRectangleC
		set myRectangleD to duplicate myRectangleC
		set myResult to transform again myRectangleD
		set myRectangleE to duplicate myRectangleD
		set myResult to transform again myRectangleE
		set myRectangleF to duplicate myRectangleE
		set myResult to transform again myRectangleF
		set myRectangleG to duplicate myRectangleF
		set myResult to transform again myRectangleG
		set myRectangleH to duplicate myRectangleG
		set myResult to transform again myRectangleH
		transform myRectangleB in pasteboard coordinates from center anchor with matrix myTransformationMatrix
		set myResult to transform again myRectangleD
		set myResult to transform again myRectangleF
		set myResult to transform again myRectangleH
		--![Transform again.]
	end tell
end mySnippet
on mySetup()
	tell application "Adobe InDesign 2024"
		set when scaling of transform preferences to adjust scaling percentage
		set myDocument to make document
		tell myDocument
			tell view preferences
				set horizontal measurement units to points
				set vertical measurement units to points
			end tell
			set myPage to page 1
			set myPageBounds to bounds of myPage
			set myPageXCenter to ((item 4 of myPageBounds) - (item 2 of myPageBounds)) / 2
			set myPageYCenter to ((item 3 of myPageBounds) - (item 1 of myPageBounds)) / 2
			set zero point to {myPageXCenter, myPageYCenter}
			tell myPage
				make guide with properties {orientation:horizontal, location:0}
				make guide with properties {orientation:vertical, location:0}
				make rectangle with properties {geometric bounds:{-72, -72, 72, 72}}
			end tell
		end tell
	end tell
end mySetup
on myTeardown()
end myTeardown
