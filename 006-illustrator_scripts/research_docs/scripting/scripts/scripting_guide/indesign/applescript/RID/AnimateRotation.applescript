--AnimateRotation.applescript
--An InDesign AppleScript
--
--Shows how to rotate a page item as it is animated.
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
			set ruler origin to page origin
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		tell myDocument
			set myPage to page 1
			set myColorA to my myAddColor(myDocument, "DGC1_446a", CMYK, process, {0, 100, 0, 50})
			--![Animate rotation.]
			--Given a document "myDocument" and a page "myPage" and the color "myColorA"...
			--Add a page items to animate.
			tell page 1
				set myPolygon to make polygon with properties {fill color:myColorA, stroke color:"None"}
			end tell
			--Create a motion path.
			set entire path of path 1 of myPolygon to {{72, 72}, {72, 144}, {144, 108}}
			set myMotionPathPoints to {{{{108, 108}, {108, 108}, {108, 108}}, {{516, 108}, {516, 108}, {516, 108}}}, true}
			--Set animation preferences for the polygon.
			tell animation settings of myPolygon
				set duration to 2
				set motion path points to myMotionPathPoints
				--Assuming 24 Frames Per Second (FPS)
				--23 = 1 second, 47 = 2 seconds, 71 = 3 seconds, 95 = 4 seconds, 
				--119 = 5 seconds, 143 = 6 seconds
				--Since the duration of our animation is 2 seconds, the following line will
				--make the polygon rotate 360 degrees from the start to the end
				--of the animation.
				set rotation array to {{0, 0}, {47, 360}}
			end tell
			set myTimingSettings to timing settings of parent of myPage
			tell myTimingSettings
				--Remove the default timing list.
				delete timing list 1
				--Add a new timing list that triggers when the page is clicked.
				set myTimingList to make timing list with properties {trigger event:on page click}
				tell myTimingList
					--Add the polygon to a single timing group.
					make timing group with properties {dynamic target:myPolygon, delay seconds:0}
				end tell
			end tell
			--![Animate rotation.]
		end tell
	end tell
end mySnippet
on myTeardown()
end myTeardown
on myAddColor(myDocument, myColorName, myColorSpace, myColorModel, myColorValue)
	tell application "Adobe InDesign 2024"
		tell myDocument
			try
				set myColor to color myColorName
			on error
				set myColor to make color with properties {name:myColorName}
			end try
			set properties of myColor to {space:myColorSpace, model:myColorModel, color value:myColorValue}
			return myColor
		end tell
	end tell
end myAddColor
