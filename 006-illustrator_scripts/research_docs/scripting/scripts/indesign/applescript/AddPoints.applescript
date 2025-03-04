--AddPoints.applescript
--An InDesign AppleScript
--
--Adds points to the paths in the selected objects. If the line segment (i.e., the part of
--the path between two anchor points) is straight, or if  the line segment is a section
--of a circular arc, the added point will appear exactly half the distance between the 
--two anchor points. If the line segment is an irregular curve, AddPoints will add the 
--point according according to the "velocity" of the curve; points tend to be closer to
--the point containing greater distances from the anchor point to the left or right direction
--handles.
--
--For more on InDesign/InCopy scripting see the documentation included in the Scripting SDK 
--available at http://www.adobe.com/devnet/indesign/sdk.html
--or visit the InDesign Scripting forum at http://www.adobeforums.com
--
tell application "Adobe InDesign 2024"
	set myTypeList to {rectangle, polygon, oval, graphic line, text frame}
	if (count documents) is not equal to 0 then
		set mySelection to selection
		if (count mySelection) is not equal to 0 then
			repeat with myCounter from 1 to (count mySelection)
				set myObject to item myCounter of mySelection
				if class of myObject is in myTypeList then
					repeat with myPathCounter from 1 to count paths of myObject
						set myPath to path myPathCounter of myObject
						if path type of myPath is closed path then
							set myClosedPath to true
						else
							set myClosedPath to false
						end if
						set myEntirePath to entire path of myPath
						set myNewPath to my myAddPoints(myEntirePath, myClosedPath)
						set entire path of myPath to myNewPath
					end repeat
				end if
			end repeat
		else
			display dialog "No objects are selected. Please select an object and try again."
		end if
	else
		display dialog "No documents are open. Please open a document, select an object, and try again."
	end if
end tell
on myAddPoints(myEntirePath, myClosedPath)
	set myNewPath to {}
	repeat with myCounter from 1 to (count myEntirePath)
		set myPoint to item myCounter of myEntirePath
		if (count myPoint) < 3 then
			set myAnchor to myPoint
			set myRightDirection to myAnchor
			if myCounter is not equal to (count myEntirePath) then
				set {myBx2, myBy2} to item (myCounter + 1) of myEntirePath
				set {myBx3, myBy3} to item (myCounter + 1) of myEntirePath
			else
				set {myBx2, myBy2} to item 1 of myEntirePath
				set {myBx3, myBy3} to item 1 of myEntirePath
			end if
		else
			set myAnchor to item 2 of myPoint
			set myRightDirection to item 3 of myPoint
			if myCounter is not equal to (count myEntirePath) then
				set {myBx2, myBy2} to item 1 of item (myCounter + 1) of myEntirePath
				set {myBx3, myBy3} to item 2 of item (myCounter + 1) of myEntirePath
			else
				set {myBx2, myBy2} to item 1 of item 1 of myEntirePath
				set {myBx3, myBy3} to item 2 of item 1 of myEntirePath
			end if
		end if
		set {myBx0, myBy0} to myAnchor
		set {myBx1, myBy1} to myRightDirection
		set {myPointA, myPointB, myPointC} to my myCalculatePoints(myBx0, myBy0, myBx1, myBy1, myBx2, myBy2, myBx3, myBy3)
		if myCounter = 1 then
			--For the first point on the path, simply copy the points into the myNewPath list.
			copy myPointA to end of myNewPath
			copy myPointB to end of myNewPath
			copy myPointC to end of myNewPath
		else
			if myCounter = (count myEntirePath) then
				if myClosedPath is true then
					--If we've reached the end of the path, and the path is a closed path, then
					--add the intermediate point and adjust the right direction of the preceding point
					--and the left direction handle of the first point
					set item 3 of item (count myNewPath) of myNewPath to item 3 of myPointA
					copy myPointB to end of myNewPath
					set item 1 of item 1 of myNewPath to item 1 of myPointC
				end if
			else
				set item 3 of item (count myNewPath) of myNewPath to item 3 of myPointA
				copy myPointB to end of myNewPath
				copy myPointC to end of myNewPath
			end if
		end if
	end repeat
	return myNewPath
end myAddPoints
on myCalculatePoints(myBx0, myBy0, myBx1, myBy1, myBx2, myBy2, myBx3, myBy3)
	if myBx1 = myBx0 and myBy1 = myBy0 and myBx2 = myBx3 and myBy2 = myBy3 then
		--anchor of point 1 of segment 1
		set myCx0 to myBx0
		set myCy0 to myBy0
		--anchor of point 2 of segment 1
		set myCx3 to (myBx3 + (3 * myBx2) + (3 * myBx1) + myBx0) * 0.125
		set myCy3 to (myBy3 + (3 * myBy2) + (3 * myBy1) + myBy0) * 0.125
		-- anchor of point 1 of segment 2 (not really necessary; same as ending of segment 1)
		set myDx0 to (myBx3 + (3 * myBx2) + (3 * myBx1) + myBx0) * 0.125
		set myDy0 to (myBy3 + (3 * myBy2) + (3 * myBy1) + myBy0) * 0.125
		--anchor of point 2 of segment 2
		set myDx3 to myBx3
		set myDY3 to myBy3
		--right direction of point 1 of segment 1
		set myCx1 to myCx0
		set myCy1 to myCy0
		--left direction of point 2 of segment 1
		set myCx2 to myCx3
		set myCy2 to myCy3
		--right direction of point 2 of segment 1 (i.e., point 1 of segment 2)
		set myDx1 to myDx0
		set myDy1 to myDy0
		--left direction of point 2 of segment 2
		set myDx2 to myDx3
		set myDy2 to myDY3
	else
		--anchor of point 1 of segment 1
		set myCx0 to myBx0
		set myCy0 to myBy0
		-- right direction of point 1 of segment 1
		set myCx1 to (myBx1 + myBx0) * 0.5
		set myCy1 to (myBy1 + myBy0) * 0.5
		-- left direction of point 2 of segment 1
		set myCx2 to (myBx2 + (2 * myBx1) + myBx0) * 0.25
		set myCy2 to (myBy2 + (2 * myBy1) + myBy0) * 0.25
		-- anchor of point 2 of segment 1
		set myCx3 to (myBx3 + (3 * myBx2) + (3 * myBx1) + myBx0) * 0.125
		set myCy3 to (myBy3 + (3 * myBy2) + (3 * myBy1) + myBy0) * 0.125
		-- anchor of point 1 of segment 2 (not really necessary; same as ending of segment 1)
		set myDx0 to (myBx3 + (3 * myBx2) + (3 * myBx1) + myBx0) * 0.125
		set myDy0 to (myBy3 + (3 * myBy2) + (3 * myBy1) + myBy0) * 0.125
		--right direction of point 2 of segment 1 (i.e., point 1 of segment 2)
		set myDx1 to (myBx3 + (2 * myBx2) + myBx1) * 0.25
		set myDy1 to (myBy3 + (2 * myBy2) + myBy1) * 0.25
		--left direction of point 2 of segment 2
		set myDx2 to (myBx3 + myBx2) * 0.5
		set myDy2 to (myBy3 + myBy2) * 0.5
		--anchor of point 2 of segment 2
		set myDx3 to myBx3
		set myDY3 to myBy3
	end if
	set myPointA to {{myCx0, myCy0}, {myCx0, myCy0}, {myCx1, myCy1}}
	set myPointB to {{myCx2, myCy2}, {myCx3, myCy3}, {myDx1, myDy1}}
	set myPointC to {{myDx2, myDy2}, {myDx3, myDY3}, {myDx3, myDY3}}
	return {myPointA, myPointB, myPointC}
end myCalculatePoints
