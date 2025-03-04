--TransformAnimation.applescript
--An InDesign AppleScript
--
--Shows how to apply multiple transformations to an animated object.
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
			set myOvalA to make oval with properties {fill color:myColorA, stroke color:"None", geometric bounds:{66, 66, 78, 78}}
			set myOvalB to make oval with properties {fill color:myColorB, stroke color:"None", geometric bounds:{66, 66, 78, 78}}
			set myOvalC to make oval with properties {fill color:myColorC, stroke color:"None", geometric bounds:{66, 66, 78, 78}}
		end tell
		--![Transform animation.]
		--Given a page containing ovals "myOvalA," "myOvalB," and "myOvalC"... 
		--The motion path is constructed relative to the center of the object, and key frames
		--are based on the duration of the animation divided by the number of frames per second
		--(usually 24). The following array sets key frames at the start, midpoint, and end
		--of a path.
		set myMotionPath to {{0, {{0, 0}, {0, 0}, {0, 0}}}, {23, {{234, 0}, {234, 0}, {234, 0}}}, {47, {{468, 0}, {468, 0}, {468, 0}}}}
		tell animation settings of myOvalA
			set duration to 2
			set motion path to myMotionPath
			--The transformation changes at each key frame.
			--scale x array in the form {{keyframe, scale_percentage}, {keyframe, scalePercentage}, ...}
			set scale x array to {{0, 100}, {23, 200}, {47, 100}}
			--scale y array in the form {{keyframe, scale_percentage}, {keyframe, scalePercentage}, ...}
			set scale y array to {{0, 100}, {23, 200}, {47, 100}}
			--opacity array in the form {{keyframe, opacity}, {keyframe, opacity},...}
			set opacity array to {{0, 100}, {23, 20}, {47, 100}}
			set plays loop to true
		end tell
		tell animation settings of myOvalB
			set duration to 2
			set motion path to myMotionPath
			set scale x array to {{0, 200}, {23, 300}, {47, 50}}
			set scale y array to {{0, 200}, {23, 300}, {47, 50}}
			set opacity array to {{0, 10}, {23, 80}, {47, 60}}
			set plays loop to true
		end tell
		tell animation settings of myOvalC
			set duration to 2
			set motion path to myMotionPath
			set scale x array to {{0, 50}, {23, 200}, {47, 400}}
			set scale y array to {{0, 50}, {23, 200}, {47, 400}}
			set opacity array to {{0, 100}, {23, 40}, {47, 80}}
			set plays loop to true
		end tell
	end tell
	--![Transform animation.]
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
