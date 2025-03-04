--CornerEffects.applescript
--An InDesign AppleScript
--
--Applies corner effects by redrawing the object.
--
--For more on InDesign/InCopy scripting see the documentation included in the Scripting SDK 
--available at http://www.adobe.com/devnet/indesign/sdk.html
--Or visit the InDesign Scripting User to User forum at http://www.adobeforums.com.
--
set myObjectList to {}
tell application "Adobe InDesign 2024"
	set myObjectTypes to {rectangle, oval, polygon, graphic line, text frame}
	if (count documents) is not equal to 0 then
		set mySelection to selection
		if (count mySelection) is not equal to 0 then
			repeat with myObject in mySelection
				if class of myObject is in myObjectTypes then
					copy myObject to end of myObjectList
				end if
			end repeat
			if (count myObjectList) is not equal to 0 then
				my myDisplayDialog(myObjectList)
			else
				display dialog ("Please select a rectangle, oval, polygon, text frame, or graphic line and try again.")
			end if
		else
			display dialog ("Please select an object and try again.")
		end if
	else
		display dialog ("Please open a document, select an object, and try again.")
	end if
end tell
on myDisplayDialog(myObjectList)
	tell application "Adobe InDesign 2024"
		set myStringList to {"all points", "first point", "last point", "second point", "third point", "fourth point", "first two", "second and third", "last two", "first and last", "odd points", "even points"}
		--Store the current measurement units.
		set myOldXUnits to horizontal measurement units of view preferences of active document
		set myOldYUnits to vertical measurement units of view preferences of active document
		set horizontal measurement units of view preferences of active document to points
		set vertical measurement units of view preferences of active document to points
		set myDialog to make dialog with properties {name:"CornerEffects"}
		tell myDialog
			tell (make dialog column)
				tell (make border panels)
					make static text with properties {static label:"Corner Type:"}
					set myCornerEffectButtons to make radiobutton group
					tell myCornerEffectButtons
						make radiobutton control with properties {static label:"Rounded", checked state:true}
						make radiobutton control with properties {static label:"Inverse Rounded"}
						make radiobutton control with properties {static label:"Bevel"}
						make radiobutton control with properties {static label:"Inset"}
						make radiobutton control with properties {static label:"Fancy"}
					end tell
				end tell
				tell (make border panel)
					tell (make dialog column)
						make static text with properties {static label:"Options:"}
					end tell
					tell (make dialog column)
						tell (make dialog row)
							tell (make dialog column)
								make static text with properties {static label:"Offset:", min width:50}
								make static text with properties {static label:"Pattern:", min width:50}
							end tell
							tell (make dialog column)
								set myOffsetEditbox to make measurement editbox with properties {edit value:12}
								set myPatternDropdown to make dropdown with properties {string list:myStringList, selected index:0}
							end tell
						end tell
					end tell
				end tell
			end tell
		end tell
		set myReturn to show myDialog
		if myReturn is true then
			--Get the values from the dialog box.
			set myCornerType to selected button of myCornerEffectButtons
			set myOffset to edit value of myOffsetEditbox
			set myPattern to item ((selected index of myPatternDropdown) + 1) of myStringList
			destroy myDialog
			repeat with myCounter from 1 to (count myObjectList)
				my myChangeCorners(item myCounter of myObjectList, myCornerType, myOffset, myPattern)
			end repeat
			--Reset the measurement units.
			set horizontal measurement units of view preferences of active document to myOldXUnits
			set vertical measurement units of view preferences of active document to myOldYUnits
		else
			destroy myDialog
		end if
	end tell
end myDisplayDialog
on myChangeCorners(myObject, myCornerType, myOffset, myPattern)
	tell application "Adobe InDesign 2024"
		repeat with myPath in paths of myObject
			set myPointArray to {}
			repeat with myPathPointCounter from 1 to (count path points in myPath)
				--Is the point a qualifying point?
				if my myPointTest(myPathPointCounter, myPath, myPattern) is false then
					set myX1 to item 1 of left direction of path point myPathPointCounter of myPath
					set myY1 to item 2 of left direction of path point myPathPointCounter of myPath
					set myX2 to item 1 of anchor of path point myPathPointCounter of myPath
					set myY2 to item 2 of anchor of path point myPathPointCounter of myPath
					set myX3 to item 1 of right direction of path point myPathPointCounter of myPath
					set myY3 to item 2 of right direction of path point myPathPointCounter of myPath
					set myPoint to {{myX1, myY1}, {myX2, myY2}, {myX3, myY3}}
					copy myPoint to end of myPointArray
				else
					set myPointA to path point myPathPointCounter of myPath
					set myAnchor to anchor of myPointA
					set myX1 to item 1 of myAnchor
					set myY1 to item 2 of myAnchor
					--myPointB is the *next* point on the path. If myPathPoint is the last point on the path, then
					--myPointB is the first point on the path.
					if myPathPointCounter is equal to (count path points of myPath) then
						set myPointB to path point 1 of myPath
					else
						set myPointB to path point (myPathPointCounter + 1) of myPath
					end if
					set myAnchor to anchor of myPointB
					set myX2 to item 1 of myAnchor
					set myY2 to item 2 of myAnchor
					--myPointC is the *previous* point on the path. If myPathPoint is the first point on the path,
					--then myPointC is the last point on the path.
					if myPathPointCounter is equal to 1 then
						set myPointC to path point -1 of myPath
					else
						set myPointC to path point (myPathPointCounter - 1) of myPath
					end if
					set myAnchor to anchor of myPointC
					set myX3 to item 1 of myAnchor
					set myY3 to item 2 of myAnchor
					set {myNewX1, myNewY1, myNewX2, myNewY2} to my myAddPoints(myX1, myY1, myX2, myY2, myX3, myY3, myOffset)
					--Calculate new path point values based on the path effect type.
					--We won't add the points to the path one at a time; instead, we'll
					--create an array that holds all of the point locations and curve
					--handle positions, and we will then use the entire path property to
					--apply all of points in the path in a single action.
					if myCornerType is 0 then
						--Rounded corner effect.
						set myPoint to {{myNewX2, myNewY2}, {myNewX2, myNewY2}, {myX1, myY1}}
						copy myPoint to end of myPointArray
						set myPoint to {{myNewX1, myNewY1}, {myNewX1, myNewY1}, {myNewX1, myNewY1}}
						copy myPoint to end of myPointArray
					else if myCornerType is 1 then
						--Inverse Rounded corner effect.
						set myPoint to {{myNewX2, myNewY2}, {myNewX2, myNewY2}, {(myNewX2 + myNewX1 - myX1), (myNewY2 + myNewY1 - myY1)}}
						copy myPoint to end of myPointArray
						set myPoint to {{myNewX1, myNewY1}, {myNewX1, myNewY1}, {myNewX1, myNewY1}}
						copy myPoint to end of myPointArray
					else if myCornerType is 2 then
						--Bevel corner effect.
						set myPoint to {{myNewX2, myNewY2}, {myNewX2, myNewY2}, {myNewX2, myNewY2}}
						copy myPoint to end of myPointArray
						set myPoint to {{myNewX1, myNewY1}, {myNewX1, myNewY1}, {myNewX1, myNewY1}}
						copy myPoint to end of myPointArray
					else if myCornerType is 3 then
						--Inset corner effect.
						set myPoint to {{myNewX2, myNewY2}, {myNewX2, myNewY2}, {myNewX2, myNewY2}}
						copy myPoint to end of myPointArray
						set myPoint to {{(myNewX2 + myNewX1 - myX1), (myNewY2 + myNewY1 - myY1)}, {(myNewX2 + myNewX1 - myX1), (myNewY2 + myNewY1 - myY1)}, {(myNewX2 + myNewX1 - myX1), (myNewY2 + myNewY1 - myY1)}}
						copy myPoint to end of myPointArray
						set myPoint to {{myNewX1, myNewY1}, {myNewX1, myNewY1}, {myNewX1, myNewY1}}
						copy myPoint to end of myPointArray
					else if myCornerType is 4 then
						--Fancy corner effect.
						set myOneThird to 0.33333333332
						set myTwoThirds to 0.666666666667
						set myPointZX to myNewX2 + myNewX1 - myX1
						set myPointZY to myNewY2 + myNewY1 - myY1
						set myTemp1X to (myX1 - myNewX2) * myTwoThirds
						set myTemp1Y to (myY1 - myNewY2) * myTwoThirds
						set myTemp2X to (myX1 - myNewX1) * myTwoThirds
						set myTemp2Y to (myY1 - myNewY1) * myTwoThirds
						set myPointDX to myPointZX + myOneThird * (myNewX1 - myPointZX)
						set myPointDY to myPointZY + myOneThird * (myNewY1 - myPointZY)
						set myPointEX to myPointZX + myOneThird * (myNewX2 - myPointZX)
						set myPointEY to myPointZY + myOneThird * (myNewY2 - myPointZY)
						set myPointFX to myPointDX + myTwoThirds * (myX1 - myTemp1X - myPointDX)
						set myPointFY to myPointDY + myTwoThirds * (myY1 - myTemp1Y - myPointDY)
						set myPointGX to myPointEX + myTwoThirds * (myX1 - myTemp2X - myPointEX)
						set myPointGY to myPointEY + myTwoThirds * (myY1 - myTemp2Y - myPointEY)
						set myPointHX to myPointZX + myTemp1X + myTemp2X
						set myPointHY to myPointZY + myTemp1Y + myTemp2Y
						set myPoint to {{myNewX2, myNewY2}, {myNewX2, myNewY2}, {myNewX2, myNewY2}}
						copy myPoint to end of myPointArray
						set myPoint to {{myPointEX, myPointEY}, {myPointEX, myPointEY}, {myPointEX, myPointEY}}
						copy myPoint to end of myPointArray
						set myPoint to {{myPointGX, myPointGY}, {myPointGX, myPointGY}, {myPointGX, myPointGY}}
						copy myPoint to end of myPointArray
						set myPoint to {{myPointHX, myPointHY}, {myPointHX, myPointHY}, {myPointHX, myPointHY}}
						copy myPoint to end of myPointArray
						set myPoint to {{myPointFX, myPointFY}, {myPointFX, myPointFY}, {myPointFX, myPointFY}}
						copy myPoint to end of myPointArray
						set myPoint to {{myPointDX, myPointDY}, {myPointDX, myPointDY}, {myPointDX, myPointDY}}
						copy myPoint to end of myPointArray
						set myPoint to {{myNewX1, myNewY1}, {myNewX1, myNewY1}, {myNewX1, myNewY1}}
						copy myPoint to end of myPointArray
					end if
				end if
			end repeat
			set entire path of myPath to myPointArray
		end repeat
	end tell
end myChangeCorners

on myAddPoints(myX1, myY1, myX2, myY2, myX3, myY3, myOffset)
	set myHypotenuse to ((myX1 - myX2) ^ 2 + (myY1 - myY2) ^ 2) ^ 0.5
	if myY1 is not equal to myY2 then
		set myXAdjust to ((myX1 - myX2) / myHypotenuse) * myOffset
		set myYAdjust to ((myY1 - myY2) / myHypotenuse) * myOffset
		set myNewX1 to myX1 - myXAdjust
		set myNewY1 to myY1 - myYAdjust
	else
		set myXAdjust to myOffset
		set myYAdjust to 0
		if myX1 < myX2 then
			set myNewX1 to myX1 + myXAdjust
			set myNewY1 to myY1 + myYAdjust
		else
			set myNewX1 to myX1 - myXAdjust
			set myNewY1 to myY1 - myYAdjust
		end if
	end if
	set myHypotenuse to ((myX1 - myX3) ^ 2 + (myY1 - myY3) ^ 2) ^ 0.5
	if myY1 is not equal to myY3 then
		set myXAdjust to ((myX1 - myX3) / myHypotenuse) * myOffset
		set myYAdjust to ((myY1 - myY3) / myHypotenuse) * myOffset
		set myNewX2 to myX1 - myXAdjust
		set myNewY2 to myY1 - myYAdjust
	else
		set myXAdjust to myOffset
		set myYAdjust to 0
		if myX1 < myX3 then
			set myNewX2 to myX1 + myXAdjust
			set myNewY2 to myY1 + myYAdjust
		else
			set myNewX2 to myX1 - myXAdjust
			set myNewY2 to myY1 - myYAdjust
		end if
	end if
	return {myNewX1, myNewY1, myNewX2, myNewY2}
end myAddPoints

on myPointTest(myPathPointCounter, myPath, myPattern)
	tell application "Adobe InDesign 2024"
		--Do not apply the corner effect to the first or last point in an open path 
		--(this is the way that InDesign's corner effects work).
		if ((path type of myPath is open path) and ((myPathPointCounter is equal to 1) or (myPathPointCounter is equal to (count path points of myPath)))) then
			return false
		else
			if myPattern is equal to "all points" then
				return true
			else if myPattern is equal to "first point" then
				if myPathPointCounter is equal to 1 then
					return true
				else
					return false
				end if
			else if myPattern is equal to "last point" then
				if myPathPointCounter is equal to (count path points in myPath) then
					return true
				else
					return false
				end if
			else if myPattern is equal to "second point" then
				if myPathPointCounter is equal to 2 then
					return true
				else
					return false
				end if
			else if myPattern is equal to "third point" then
				if myPathPointCounter is equal to 3 then
					return true
				else
					return false
				end if
			else if myPattern is equal to "fourth point" then
				if myPathPointCounter is equal to 4 then
					return true
				else
					return false
				end if
			else if myPattern is equal to "first two" then
				if (myPathPointCounter is equal to 1) or (myPathPointCounter is equal to 2) then
					return true
				else
					return false
				end if
			else if myPattern is equal to "second and third" then
				if (myPathPointCounter is equal to 2) or (myPathPointCounter is equal to 3) then
					return true
				else
					return false
				end if
			else if myPattern is equal to "last two" then
				if ((myPathPointCounter is equal to (count path points of myPath) - 1) or (myPathPointCounter is equal to (count path points of myPath))) then
					return true
				else
					return false
				end if
			else if myPattern is equal to "first and last" then
				if ((myPathPointCounter is equal to 1) or (myPathPointCounter is equal to (count path points of myPath))) then
					return true
				else
					return false
				end if
			else if myPattern is equal to "even points" then
				if myPathPointCounter mod 2 = 0 then
					return true
				else
					return false
				end if
			else if myPattern is equal to "odd points" then
				if myPathPointCounter mod 2 is not equal to 0 then
					return true
				else
					return false
				end if
			end if
		end if
	end tell
end myPointTest
