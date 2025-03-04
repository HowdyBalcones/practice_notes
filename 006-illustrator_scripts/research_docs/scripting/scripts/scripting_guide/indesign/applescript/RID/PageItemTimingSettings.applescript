--MultipleTimingLists.applescript
--An InDesign AppleScript
--
--Shows how to work with the timing settings of a page item.
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
		set myPage to page 1 of myDocument
		set myColorA to my myAddColor(myDocument, "DGC1_446a", CMYK, process, {0, 100, 0, 50})
		--![Page item timing settings.]
		--Given a page "myPage"...
		tell myPage
			set myPolygonA to make polygon with properties {fill color:myColorA, stroke color:"None"}
			set entire path of path 1 of myPolygonA to {{72, 72}, {72, 144}, {144, 108}}
			--Create a motion path.
			set myMotionPathPointsA to {{{{108, 108}, {108, 108}, {108, 108}}, {{516, 108}, {516, 108}, {516, 108}}}, true}
			--Set animation preferences for the polygon.
			tell animation settings of myPolygonA
				set duration to 2
				set motion path points to myMotionPathPointsA
			end tell
			--Remove the default timing list in the timing settings for the spread.
			set myTimingSettings to timing settings of parent of myPage
			tell myTimingSettings
				delete timing list 1
			end tell
			set myTimingSettings to timing settings of myPolygonA
			tell myTimingSettings
				set myTimingList to make timing list with properties {trigger event:on click}
			end tell
			tell myTimingList
				set myTimingGroup to make timing group with properties {dynamic target:myPolygonA, delay seconds:0}
			end tell
		end tell
		--![Page item timing settings.]
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
