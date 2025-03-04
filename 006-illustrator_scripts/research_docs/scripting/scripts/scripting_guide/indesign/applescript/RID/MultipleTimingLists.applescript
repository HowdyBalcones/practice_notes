--MultipleTimingLists.applescript
--An InDesign AppleScript
--
--Shows how to work with multiple timing lists in an animation.
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
		--![Multiple timing lists.]
		set myTimingSettings to timing settings of parent of myPage
		tell myTimingSettings
			--At this point, all of the polygons have already been added as timing targets
			--of the default timing list. Change the delay of myPolygonB and myPolygonC,
			--which are the targets of the second and third timing groups.
			set myTimingListA to timing list 1
			tell myTimingListA
				tell timing group 2
					set delay seconds of timing target 1 to 2
				end tell
				tell timing group 3
					set delay seconds of timing target 1 to 2
				end tell
				--Remove the last three timing groups in the timing list.
				--We have to do this, because we don't want these polygons to be
				--animated when the page loads.				
				delete timing group -1
				delete timing group -1
				delete timing group -1
			end tell
			--Add a new timing list that triggers when the page is clicked.
			set myTimingListB to make timing list with properties {trigger event:on page click}
			tell myTimingListB
				set myTimingGroupB to make timing group with properties {dynamic target:myPolygonD, delay seconds:0}
				tell myTimingGroupB
					make timing target with properties {dynamic target:myPolygonE, delay seconds:2}
					make timing target with properties {dynamic target:myPolygonF, delay seconds:2}
				end tell
			end tell
		end tell
		--![Multiple timing lists.]
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
