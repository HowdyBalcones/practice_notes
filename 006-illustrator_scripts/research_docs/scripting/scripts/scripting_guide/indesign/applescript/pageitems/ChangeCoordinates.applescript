--ChangeCoordinates.applescript
--An InDesign AppleScript
--
--Shows how to use the change coordinates method.
main()
on main()
	my mySetup()
	my mySnippet()
end main
on mySnippet()
	tell application "Adobe InDesign 2024"
		--<fragment>
		set myPage to page 1 of document 1
		my myDrawPolygon(myPage, {0, 0}, 12, 144, true, 0.5)
		my myDrawPolygon(myPage, {0, 144}, 12, 72, true, 0.5)
		my myDrawPolygon(myPage, {144, 0}, 24, 72, true, 0.75)
		my myDrawPolygon(myPage, {0, -144}, 24, 72, true, 0.5)
		my myDrawPolygon(myPage, {-144, 0}, 48, 72, true, 0.5)
		--</fragment>	
	end tell
end mySnippet
on mySetup()
	tell application "Adobe InDesign 2024"
		set when scaling of transform preferences to adjust scaling percentage
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
			end tell
		end tell
	end tell
end mySetup
--![Change coordinates.]
--General purpose routine for drawing regular polygons from their center point.
on myDrawPolygon(myParent, myCenterPoint, myNumberOfPoints, myRadius, myStarPolygon, myStarInset)
	local myPathPoints, myTransformedPoint
	tell application "Adobe InDesign 2024"
		set myPathPoints to {}
		set myPoint to {0, 0}
		if myStarPolygon is true then
			set myNumberOfPoints to myNumberOfPoints * 2
		end if
		set myInnerRadius to myRadius * myStarInset
		set myAngle to 360 / myNumberOfPoints
		set myRotateMatrix to make transformation matrix with properties {counterclockwise rotation angle:myAngle}
		set myOuterTranslateMatrix to make transformation matrix with properties {horizontal translation:myRadius}
		set myInnerTranslateMatrix to make transformation matrix with properties {horizontal translation:myInnerRadius}
		repeat with myPointCounter from 0 to myNumberOfPoints - 1
			--Translate the point to the inner/outer radius.
			if myStarInset = 1 or my myIsEven(myPointCounter) is true then
				set myTransformedPoint to change coordinates myOuterTranslateMatrix point myPoint
			else
				set myTransformedPoint to change coordinates myInnerTranslateMatrix point myPoint
			end if
			--Rotate the point.
			set myTransformedPoint to change coordinates myRotateMatrix point myTransformedPoint
			copy myTransformedPoint to the end of myPathPoints
			set myRotateMatrix to rotate matrix myRotateMatrix by angle myAngle
		end repeat
		--Create a new polygon.
		tell myParent
			set myPolygon to make polygon
		end tell
		--Set the entire path of the polygon to the array we've created.
		set entire path of path 1 of myPolygon to myPathPoints
		--If the center point is somewhere other than [0,0], translate the polygon to the center point.
		if item 1 of myCenterPoint is not equal to 0 or item 2 of myCenterPoint is not equal to 0 then
			set myTransformationMatrix to make transformation matrix with properties {horizontal translation:item 1 of myCenterPoint, vertical translation:item 2 of myCenterPoint}
			transform myPolygon in pasteboard coordinates from {myCenterPoint, center anchor} with matrix myTransformationMatrix with considering ruler units
		end if
	end tell
end myDrawPolygon
--This function returns true if myNumber is even, false if it is not.
on myIsEven(myNumber)
	set myResult to myNumber mod 2
	if myResult = 0 then
		set myResult to true
	else
		set myResult to false
	end if
	return myResult
end myIsEven
--![Change coordinates.]
