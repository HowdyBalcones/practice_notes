--DrawRegularPolygon_Slow.applescript
--An InDesign AppleScript
--
--Shows how to draw a regular polygon around a specific location
--by specifying the position of individual path points.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		tell view preferences of myDocument
			set horizontal measurement units to points
			set vertical measurement units to points
		end tell
		tell document preferences of myDocument
			set myPageWidth to page width
			set myPageHeight to page height
		end tell
		--Set the zero point to the center of the page.
		set zero point of myDocument to {myPageWidth / 2, myPageHeight / 2}
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		--You've probably noticed that drawing regular polygons by specifying their
		--geometric bounds often produces polygons that are squashed or stretched.
		--The following example shows how to draw a regular polygon from its center point.
		set myDocument to document 1
		--<fragment>
		--Draw a regular polygon around {0,0}.
		--The following parameters set the size and shape of the polygon.
		set myCenterPoint to {0, 0}
		set myRadius to 72
		set myNumberOfPoints to 7
		set myStarInset to 40
		--myStartingPoint ensures that the top of the star is at 90 degrees vertically from the origin.
		set myStartingPoint to 270 * (pi / 180)
		--Create a new polygon with the number of points and star inset that you want.
		--Save the current polygon preference.
		set myOldNumberOfSides to number of sides of polygon preferences
		if myStarInset is not equal to 100 then
			set myOldStarInset to inset percentage of polygon preferences
			set inset percentage of polygon preferences to myStarInset
		end if
		set number of sides of polygon preferences to myNumberOfPoints
		tell page 1 of myDocument
			set myPolygon to make polygon
		end tell
		--Restore the old polygon preference.
		set number of sides of polygon preferences to myOldNumberOfSides
		if myStarInset is not equal to 100 then
			set inset percentage of polygon preferences to myOldStarInset
		end if
		if myStarInset = 100 then
			set myStarInset to 1
		else
			set myNumberOfPoints to myNumberOfPoints * 2
			set myStarInset to myStarInset * 0.01
			set myInsideRadius to myRadius * myStarInset
		end if
		set myAngleIncrement to ((360 / myNumberOfPoints) * (pi / 180))
		--Now we have a polygon with the correct number of points.
		--Move the points on the first path of the polygon into the correct locations.
		repeat with myPointCounter from 1 to myNumberOfPoints
			set myPoint to item myPointCounter of path points of path 1 of myPolygon
			set myAngle to myStartingPoint + (myAngleIncrement * (myPointCounter - 1))
			set myCos to my myCosine(myAngle)
			set mySin to my mySine(myAngle)
			if ((myStarInset = 1) or (my myIsEven(myPointCounter) = true)) then
				set myX to ((item 1 of myCenterPoint) + (myRadius * myCos))
				set myY to ((item 2 of myCenterPoint) + (myRadius * mySin))
			else
				set myX to ((item 1 of myCenterPoint) + (myInsideRadius * myCos))
				set myY to ((item 2 of myCenterPoint) + (myInsideRadius * mySin))
			end if
			--Move the anchor point to the calculated location.
			set anchor of myPoint to {myX, myY}
		end repeat
		--</fragment>
	end tell
end mySnippet
on myTeardown()
end myTeardown
--This function uses a JavaScript to get the sine of an angle
--(AppleScript lacks trigonometric functions).
on mySine(myAngle)
	tell application "Adobe InDesign 2024"
		set myJavaScript to "Math.sin(arguments[0])"
		set myArguments to {myAngle}
		set myValue to do script myJavaScript language javascript with arguments myArguments
	end tell
	return myValue
end mySine
on myCosine(myAngle)
	tell application "Adobe InDesign 2024"
		set myJavaScript to "Math.cos(arguments[0])"
		set myArguments to {myAngle}
		set myValue to do script myJavaScript language javascript with arguments myArguments
	end tell
	return myValue
end myCosine
--This function returns true if myNumber is even, false if it is not.
on myIsEven(myNumber)
	set myResult to myNumber mod 2
	if myResult is 0 then
		set myResult to true
	else
		set myResult to false
	end if
	return myResult
end myIsEven
