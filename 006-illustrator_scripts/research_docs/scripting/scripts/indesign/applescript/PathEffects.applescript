--PathEffects.as
--An InDesign AppleScript
--
--Changes the shape of the paths of the objects in 
--the selection in a variety of ways:
--"punk" pushes all direction handles toward the center of the path
--"bloat" pushes all direction handles away from the center of the path
--"punkbloat" pushes the left direction handle toward the
--center of the path and pushes the right direction handle
--away from the center of the path.
--"bloatpunk" pushes the right direction handle toward the
--center of the path and pushes the left direction handle
--away from the center of the path.
--"twirl" pushes all right direction handles toward the center of the path and
--leaves the left direction handle unchanged.
--"antitwirl" pushes all left direction handles toward the center of 
--the path and leaves the right direction handles unchanged.
--"convert to rectangle" converts the paths in the selected object
--to a rectangle. Note that this will result in overlapping paths 
--if the original object contains mulitple paths.
--"convert to oval" converts the paths in the selected object
--to an oval. Note that this will result in overlapping paths 
--if the original object contains mulitple paths.
--"retract all" retracts all control handles, resulting in a path
--containing only straight line segments.
--
--Note that some settings for some of these effects are mathematically 
--equivalent (setting myEffect to "bloat" and myOffset to -.5 is the same 
--as setting myEffect to "punk" and myOffset to .5, for example)
--"myOffset" is the percentage of the distance from the
--point to the center of the path, and is used to set the
--position of the direction handles. Values in the .9 to .99
--range yield subtle effects; lower values (.1, .2) give more 
--obvious effects. Values greater than 1 or less than zero produce 
--more radical change in the shape of the path.
--
--For more on InDesign/InCopy scripting see the documentation included in the Scripting SDK 
--available at http://www.adobe.com/devnet/indesign/sdk.html
--or visit the InDesign Scripting User to User forum at http://www.adobeforums.com
--
set myObjectList to {}
tell application "Adobe InDesign 2024"
	set myPageItemTypes to {rectangle, oval, polygon, graphic line, text frame}
	if (count documents) > 0 then
		set mySelection to selection
		if (count mySelection) > 0 then
			repeat with myCounter from 1 to (count mySelection)
				if (class of item myCounter of mySelection) is in myPageItemTypes then
					copy item myCounter of mySelection to end of myObjectList
				end if
			end repeat
			if (count myObjectList) > 0 then
				my myDisplayDialog(myObjectList)
			end if
		else
			display dialog "Please select a page item and try again."
		end if
	else
		display dialog "Please open a document, select a page item, and try again."
	end if
end tell
--The following handler takes care of displaying the script's dialog box.
on myDisplayDialog(myObjectList)
	tell application "Adobe InDesign 2024"
		activate
		set myDialog to make dialog with properties {name:"PathEffects"}
		tell myDialog
			tell (make dialog column)
				tell (make border panel)
					make static texts with properties {static label:"Effect:"}
					set myPathEffectButtons to make radiobutton group
					tell myPathEffectButtons
						make radiobutton control with properties {static label:"Punk", checked state:true}
						make radiobutton control with properties {static label:"Bloat"}
						make radiobutton control with properties {static label:"PunkBloat"}
						make radiobutton control with properties {static label:"BloatPunk"}
						make radiobutton control with properties {static label:"Twirl"}
						make radiobutton control with properties {static label:"AntiTwirl"}
						make radiobutton control with properties {static label:"RetractAll"}
						make radiobutton control with properties {static label:"MakeRectangle"}
						make radiobutton control with properties {static label:"MakeOval"}
					end tell
				end tell
				tell (make border panel)
					make static texts with properties {static label:"Options:"}
					tell (make dialog column)
						make static texts with properties {static label:"Offset from Center Point:"}
						set myCopyPathCheckbox to make checkbox control with properties {checked state:false, static label:"Copy Path"}
					end tell
					tell (make dialog column)
						set myOffsetEditbox to make percent editbox with properties {edit value:50}
					end tell
				end tell
				make static text with properties {static label:"Refer to the script text for a description of the path effects."}
			end tell
		end tell
		set myResult to show myDialog
		if myResult is true then
			set myEffect to selected button of myPathEffectButtons
			set myOffset to (edit value of myOffsetEditbox) * 0.01
			set myCopyPath to checked state of myCopyPathCheckbox
			destroy myDialog
			my myPathEffects(myEffect, myOffset, myCopyPath, myObjectList)
		else
			destroy myDialog
		end if
	end tell
end myDisplayDialog
--The following handler passes each path to the myPathEffect handler.
on myPathEffects(myEffect, myOffset, myCopyPath, myObjectList)
	tell application "Adobe InDesign 2024"
		repeat with myObjectCounter from 1 to (count myObjectList)
			set myObject to item myObjectCounter of myObjectList
			if myCopyPath is true then
				set myObject to duplicate myObject
			end if
			tell myObject
				repeat with myPathCounter from 1 to count paths in myObject
					set myBounds to geometric bounds of myObject
					set myPath to path myPathCounter of myObject
					set myNewPath to my myPathEffect(myEffect, entire path of myPath, myBounds, myOffset)
					set entire path of myPath to myNewPath
				end repeat --myPathCounter
			end tell
		end repeat --myObjectCounter
	end tell
end myPathEffects
--This handler takes the entire path of the original path and returns
--a list containing the path point locations/control handles of the new path.
--This approach is *much* faster than walking through the path and
--setting the left and right direction handles on each path point.
on myPathEffect(myEffect, myEntirePath, myBounds, myOffset)
	set myXCenter to (item 2 of myBounds) + (((item 4 of myBounds) - (item 2 of myBounds)) / 2)
	set myYCenter to (item 1 of myBounds) + (((item 3 of myBounds) - (item 1 of myBounds)) / 2)
	if myEffect < 7 then
		repeat with myPathPointCounter from 1 to count myEntirePath
			set myPoint to item myPathPointCounter of myEntirePath
			if (count myPoint) = 2 then
				set myAnchor to myPoint
				set myLeftDirection to myPoint
				set myRightDirection to myPoint
			else
				set myLeftDirection to item 1 of myPoint
				set myAnchor to item 2 of myPoint
				set myRightDirection to item 3 of myPoint
			end if
			set myX1 to item 1 of myAnchor
			set myY1 to item 2 of myAnchor
			set myXOffset to myXCenter - myX1
			set myYOffset to myYCenter - myY1
			set myX to myXOffset * myOffset
			set myY to myYOffset * myOffset
			--Multiple if/if else statement (other languages would use "switch" or "select case")
			if myEffect = 0 then --"punk"
				set myX2 to myXCenter - myX
				set myY2 to myYCenter - myY
				set myRightDirection to {myX2, myY2}
				set myLeftDirection to {myX2, myY2}
			else if myEffect = 1 then --"bloat"
				set myX2 to myX1 - myX
				set myY2 to myY1 - myY
				set myRightDirection to {myX2, myY2}
				set myLeftDirection to {myX2, myY2}
			else if myEffect = 2 then --"punkbloat"
				set myX2 to myXCenter - myX
				set myY2 to myYCenter - myY
				set myX3 to myX1 - (myXOffset - myX)
				set myY3 to myY1 - (myYOffset - myY)
				set myRightDirection to {myX2, myY2}
				set myLeftDirection to {myX3, myY3}
			else if myEffect = 3 then --"bloatpunk"
				set myX2 to myXCenter - myX
				set myY2 to myYCenter - myY
				set myX3 to myX1 - (myXOffset - myX)
				set myY3 to myY1 - (myYOffset - myY)
				set myLeftDirection to {myX2, myY2}
				set myRightDirection to {myX3, myY3}
			else if myEffect = 4 then --"twirl"
				set myX2 to myXCenter - myX
				set myY2 to myYCenter - myY
				set myRightDirection to {myX2, myY2}
			else if myEffect = 5 then --"antitwirl"
				set myX2 to myXCenter - myX
				set myY2 to myYCenter - myY
				set myLeftDirection to {myX2, myY2}
			else if myEffect = 6 then --"retract all"
				set myLeftDirection to myAnchor
				set myRightDirection to myAnchor
			end if
			set item myPathPointCounter of myEntirePath to {myLeftDirection, myAnchor, myRightDirection}
		end repeat --myPathPointCounter
	else
		--Two special cases: convert to rectangle and convert to oval
		if myEffect = 7 then --convert to rectangle
			set {myY1, myX1, myY2, myX2} to myBounds
			set myEntirePath to {{myX1, myY1}, {myX2, myY1}, {myX2, myY2}, {myX1, myY2}}
		else
			set myMagicConstant to 0.55228474667
			set myX1 to item 2 of myBounds
			set myY1 to item 1 of myBounds
			set myX2 to item 4 of myBounds
			set myY2 to item 3 of myBounds
			set myXOffset to ((myX2 - myX1) / 2) * myMagicConstant
			set myYOffset to ((myY2 - myY1) / 2) * myMagicConstant
			set myPoint1 to {{myX1, myYCenter + myYOffset}, {myX1, myYCenter}, {myX1, myYCenter - myYOffset}}
			set myPoint2 to {{myXCenter - myXOffset, myY1}, {myXCenter, myY1}, {myXCenter + myXOffset, myY1}}
			set myPoint3 to {{myX2, myYCenter - myYOffset}, {myX2, myYCenter}, {myX2, myYCenter + myYOffset}}
			set myPoint4 to {{myXCenter + myXOffset, myY2}, {myXCenter, myY2}, {myXCenter - myXOffset, myY2}}
			set myEntirePath to {myPoint1, myPoint2, myPoint3, myPoint4}
		end if
	end if
	return myEntirePath
end myPathEffect
