--SimpleAnimation.applescript
--An InDesign AppleScript
--
--Shows how to create a very simple animation.
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
		--![Simple animation.]
		--Given a document "myDocument" and a page "myPage" and a color "myColorA"...
		--Add a page items to animate.
		tell myPage
			set myPolygon to make polygon with properties {fill color:myColorA, stroke color:"None"}
		end tell
		set entire path of path 1 of myPolygon to {{72, 72}, {72, 144}, {144, 108}}
		--Create a motion path.
		set myMotionPathPoints to {{{{108, 108}, {108, 108}, {108, 108}}, {{516, 108}, {516, 108}, {516, 108}}}, true}
		--Set animation preferences for the polygon. We havent' set a dynamic trigger
		--for the animation, so the polygon's animation will be triggered by 
		--on page load (the default).
		tell animation settings of myPolygon
			set duration to 2
			set motion path points to myMotionPathPoints
		end tell
		--![Simple animation.]
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
