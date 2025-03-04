--MultiStateObjectControl.jsx
--An InDesign JavaScript
--
--Shows how to add a button to control a multi-state object (MSO).
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
		set myColorD to my myAddColor(myDocument, "DGC1_446d", CMYK, process, {70, 50, 0, 0})
		--![Multi state object control.]
		--Given a document "myDocument" and a page "myPage" and
		--four colors "myColorA," "myColorB," "myColorC," and "myColorD"...
		tell myPage
			set myMSO to make multi state object with properties {name:"Spinner", geometric bounds:{72, 72, 144, 144}}
			--New multi-state objects contain two states when they're created. Add two more.
			tell myMSO
				set name of state 1 to "Up"
				set name of state 2 to "Right"
				make state with properties {name:"Down"}
				make state with properties {name:"Left"}
			end tell
			--Add page items to the states.
			tell state 1 of myMSO
				set myPolygon to make polygon with properties {fill color:myColorA, stroke color:"None"}
				set entire path of path 1 of myPolygon to {{72, 144}, {144, 144}, {108, 72}}
			end tell
			tell state 2 of myMSO
				set myPolygon to make polygon with properties {fill color:myColorB, stroke color:"None"}
				set entire path of path 1 of myPolygon to {{72, 72}, {72, 144}, {144, 108}}
			end tell
			tell state 3 of myMSO
				set myPolygon to make polygon with properties {fill color:myColorC, stroke color:"None"}
				set entire path of path 1 of myPolygon to {{72, 72}, {108, 144}, {144, 72}}
			end tell
			tell state 4 of myMSO
				set myPolygon to make polygon with properties {fill color:myColorD, stroke color:"None"}
				set entire path of path 1 of myPolygon to {{144, 72}, {72, 108}, {144, 144}}
			end tell
			set myButton to make button with properties {geometric bounds:{72, 72, 144, 144}}
			tell myButton
				set myRolloverState to make state
				set myClickState to make state
				set myNextStateBehavior to make goto next state behavior with properties {associated multi state object:myMSO, behavior event:mouse down, enable behavior:true, loops to next or previous:true}
			end tell
			tell myRolloverState
				set myRolloverRectangle to rectangle 1 of group 1
			end tell
			set stroke color of myRolloverRectangle to myColorD
			set stroke weight of myRolloverRectangle to 1
			set myStrokeTransparencySettings to stroke transparency settings of myRolloverRectangle
			set myDropShadowSettings to drop shadow settings of myStrokeTransparencySettings
			tell myDropShadowSettings
				set mode to drop
				set angle to 90
				set x offset to 0
				set y offset to 0
				set size to 6
			end tell
		end tell
		--![Multi state object control.]
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
