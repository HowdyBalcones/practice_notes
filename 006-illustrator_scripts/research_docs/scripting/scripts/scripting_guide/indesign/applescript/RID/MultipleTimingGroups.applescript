--MultipleTimingGroups.applescript
--An InDesign AppleScript
--
--Shows how to work with multiple timing groups in an animation.
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
		set myColorB to my myAddColor(myDocument, "DGC1_446b", CMYK, process, {100, 0, 50, 0})
		set myColorC to my myAddColor(myDocument, "DGC1_446c", CMYK, process, {50, 30, 30, 0})
		--![Multiple timing groups.]
		--Given a document "myDocument" and a page "myPage" and the color "myColorA",
		--"myColorB", and "myColorC"...
		--Add a page items to animate.
		tell myPage
			set myPolygonA to make polygon with properties {fill color:myColorA, strokeColor:"None"}
			set entire path of path 1 of myPolygonA to {{72, 72}, {72, 144}, {144, 108}}
			set myPolygonB to make polygon with properties {fill color:myColorB, strokeColor:"None"}
			set entire path of path 1 of myPolygonB to {{72, 72}, {72, 144}, {144, 108}}
			set myPolygonC to make polygon with properties {fill color:myColorC, strokeColor:"None"}
			set entire path of path 1 of myPolygonC to {{72, 72}, {72, 144}, {144, 108}}
			set myPolygonD to make polygon with properties {fill color:myColorA, strokeColor:"None"}
			set entire path of path 1 of myPolygonD to {{72, 144}, {72, 216}, {144, 180}}
			set myPolygonE to make polygon with properties {fill color:myColorB, strokeColor:"None"}
			set entire path of path 1 of myPolygonE to {{72, 144}, {72, 216}, {144, 180}}
			set myPolygonF to make polygon with properties {fill color:myColorC, strokeColor:"None"}
			set entire path of path 1 of myPolygonF to {{72, 144}, {72, 216}, {144, 180}}
		end tell
		--Create a motion path.
		set myMotionPathPointsA to {{{{108, 108}, {108, 108}, {108, 108}}, {{516, 108}, {516, 108}, {516, 108}}}, true}
		set myMotionPathPointsB to {{{{108, 180}, {108, 180}, {108, 180}}, {{516, 180}, {516, 180}, {516, 180}}}, true}
		--Set animation preferences for the polygons. 
		--DynamicTriggerEvents.onPageLoad (the default).
		set duration of animation settings of myPolygonA to 2
		set motion path points of animation settings of myPolygonA to myMotionPathPointsA
		set duration of animation settings of myPolygonB to 2
		set motion path points of animation settings of myPolygonB to myMotionPathPointsA
		set duration of animation settings of myPolygonC to 2
		set motion path points of animation settings of myPolygonC to myMotionPathPointsA
		set duration of animation settings of myPolygonD to 2
		set motion path points of animation settings of myPolygonD to myMotionPathPointsB
		set duration of animation settings of myPolygonE to 2
		set motion path points of animation settings of myPolygonE to myMotionPathPointsB
		set duration of animation settings of myPolygonF to 2
		set motion path points of animation settings of myPolygonF to myMotionPathPointsB
		set myTimingSettings to timing settings of parent of myPage
		--Remove the default timing list.
		tell myTimingSettings
			delete timing list 1
			--Add a new timing list that triggers when the page is clicked.
			set myTimingList to make timing list with properties {trigger event:on page click}
			--Add the polygons to a single timing group.
			tell myTimingList
				set myTimingGroupA to make timing group with properties {dynamic target:myPolygonA, delay seconds:0}
				tell myTimingGroupA
					make timing target with properties {dynamic target:myPolygonB, delay seconds:2}
					make timing target with properties {dynamic target:myPolygonC, delay seconds:2}
				end tell
				--myTimingGroupB will play on the second page click.
				set myTimingGroupB to make timing group with properties {dynamic target:myPolygonD, delay seconds:0}
				tell myTimingGroupB
					make timing target with properties {dynamic target:myPolygonE, delay seconds:2}
					make timing target with properties {dynamic target:myPolygonF, delay seconds:2}
				end tell
			end tell
		end tell
		--![Multiple timing groups.]
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
