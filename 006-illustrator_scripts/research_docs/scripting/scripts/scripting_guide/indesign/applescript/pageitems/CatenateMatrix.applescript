--CatenateMatrix.applescript
--An InDesign AppleScript
--
--Shows how to use the catenate matrix method.
main()
on main()
	my mySetup()
	my mySnippet()
end main
on mySnippet()
	tell application "Adobe InDesign 2024"
		--![Catenate matrix.]
		set myTransformationMatrixA to make transformation matrix with properties {counterclockwise rotation angle:30}
		set myTransformationMatrixB to make transformation matrix with properties {horizontal translation:72, vertical translation:72}
		set myRectangle to rectangle -1 of page 1 of document 1
		set myNewRectangle to duplicate myRectangle
		--Rotate the duplicated rectangle.
		transform myNewRectangle in pasteboard coordinates from center anchor with matrix myTransformationMatrixA
		set myNewRectangle to duplicate myRectangle
		--Move the duplicate (unrotated) rectangle.
		transform myNewRectangle in pasteboard coordinates from center anchor with matrix myTransformationMatrixB
		--Merge the two transformation matrices.
		set myTransformationMatrix to catenate matrix myTransformationMatrixA with matrix myTransformationMatrixB
		set myNewRectangle to duplicate myRectangle
		--The duplicated rectangle will be both moved and rotated.
		transform myNewRectangle in pasteboard coordinates from center anchor with matrix myTransformationMatrix
		--![Catenate matrix.]
	end tell
end mySnippet
on mySetup()
	tell application "Adobe InDesign 2024"
		set when scaling of transform preferences to adjust scaling percentage
		set myDocument to make document
		set when scaling of transform preferences to adjust scaling percentage
		set horizontal measurement units of view preferences of myDocument to points
		set vertical measurement units of view preferences of myDocument to points
		tell page 1 of myDocument
			set myRectangle to make rectangle with properties {geometric bounds:{72, 72, 144, 144}}
		end tell
	end tell
end mySetup
