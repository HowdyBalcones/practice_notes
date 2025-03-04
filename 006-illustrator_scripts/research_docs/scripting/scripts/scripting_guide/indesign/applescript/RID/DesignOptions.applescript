--DesignOptions.applescript
--An InDesign AppleScript
--
--Shows how use design options to control the animation of an object.
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
		tell myPage
			set myOvalA to make oval with properties {fill color:myColorA, stroke color:"None", geometric bounds:{66, 66, 78, 78}}
			set myOvalB to make oval with properties {fill color:myColorB, stroke color:"None", geometric bounds:{138, 66, 150, 78}}
		end tell
		--![Design options.]
		--Given a page containing the ovals "myOvalA" and "myOvalB"... 
		set myMotionPreset to Motion Preset "move-right-grow"
		tell animation settings of myOvalA
			set duration to 2
			set plays loop to true
			set preset to myMotionPreset
			set design option to from current appearance
		end tell
		tell animation settings of myOvalB
			set duration to 2
			set plays loop to true
			set preset to myMotionPreset
			set design option to to current appearance
		end tell
		--![Design options.]
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
