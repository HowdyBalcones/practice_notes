--FunWithTransformations.applescript
--An InDesign AppleScript
--
main()
on main()
	my mySetup()
	my mySnippet()
	my myTeardown()
end main
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--<fragment>
		--Given a document "myDocument"...
		set myPage to page 1 of myDocument
		set myPolygon to my myDrawPolygon(myPage, {0, 0}, 12, 133, true, 0.6)
		my myTransformPath(myPolygon, path 1 of myPolygon, -0.75, -0.75, 15, true)
		my myTransformPath(myPolygon, path 1 of myPolygon, 0.5, 0.5, 75, true)
		my myTransformPath(myPolygon, path 1 of myPolygon, -1.25, -1.25, 45, true)
		my myTransformPath(myPolygon, path 1 of myPolygon, -0.5, -0.5, 90, true)
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
--<fragment>
on myTransformPath(myPageItem, myPath, myXScale, myYScale, myAngle, myDuplicatePath)
	tell application "Adobe InDesign 2024"
		set myEntirePath to entire path of myPath
		if (count (item 1 of myEntirePath)) is not equal to 3 then
			set myEntirePath to my myAddDirectionPoints(myEntirePath)
		end if
		set myClockwiseMatrix to make transformation matrix with properties {horizontal scale factor:myXScale, vertical scale factor:myYScale, counterclockwise rotation angle:-myAngle}
		set myCounterClockwiseMatrix to make transformation matrix with properties {horizontal scale factor:myXScale, vertical scale factor:myYScale, counterclockwise rotation angle:myAngle}
		repeat with myCounter from 1 to (count myEntirePath)
			set myPoint to item myCounter of myEntirePath
			set item 1 of myPoint to change coordinates myClockwiseMatrix point item 1 of myPoint
			set item 3 of myPoint to change coordinates myCounterClockwiseMatrix point item 3 of myPoint
			set item myCounter of myEntirePath to myPoint
		end repeat
		if myDuplicatePath is true then
			tell myPageItem
				set myNewPath to make path
			end tell
			set path type of myNewPath to closed path
			set entire path of myNewPath to myEntirePath
		else
			set entire path of myPath to myEntirePath
		end if
	end tell
end myTransformPath
on myAddDirectionPoints(myPath)
	set myNewPath to myPath
	repeat with myCounter from 1 to count myPath
		if length of item myCounter of myPath is 2 then
			set myPointArray to {{0, 0}, {0, 0}, {0, 0}}
			repeat with myPointCounter from 1 to 3
				set item myPointCounter of myPointArray to item myCounter of myPath
			end repeat
		else
			set myPointArray to item myCounter of myPath
		end if
		set item myCounter of myNewPath to myPointArray
	end repeat
	return myNewPath
end myAddDirectionPoints
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
		return myPolygon
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
--</fragment>
on myTeardown()
end myTeardown
