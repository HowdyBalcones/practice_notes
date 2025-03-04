--ButtonStates.applescript
--An InDesign AppleScript
--
--Shows how to make a button.
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
		my myAddColor(myDocument, "Red", RGB, process, {255, 0, 0})
		my myAddColor(myDocument, "Blue", RGB, process, {0, 0, 255})
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Button states.]
		--Given a page "myPage" in a document "myDocument," containing the colors
		--"Blue" and "Red"...
		--Make a button "from scratch."
		tell page 1 of myDocument
			set myButton to make button with properties {geometric bounds:{72, 72, 144, 144}, name:"GoToNextPageButton"}
		end tell
		tell state 1 of myButton
			set myRightArrow to make polygon with properties {fill color:color "Red" of myDocument, stroke color:"None"}
			set entire path of path 1 of myRightArrow to {{72, 72}, {144, 108}, {72, 144}}
		end tell
		--Add the Rollover state.
		tell myButton
			set myRolloverState to make state
		end tell
		tell myRolloverState
			set myRolloverArrow to make polygon with properties {fill color:color "Red" of myDocument, stroke color:"None"}
			set entire path of path 1 of myRolloverArrow to {{72, 72}, {144, 108}, {72, 144}}
			--Add a shadow to the polygon in the Rollover state.
		end tell
		tell drop shadow settings of fill transparency settings of myRolloverArrow
			set mode to drop
			set angle to 90
			set x offset to 0
			set y offset to 0
			set size to 6
		end tell
		tell myButton
			set myClickState to make state
		end tell
		tell myClickState
			set myClickArrow to make polygon with properties {fill color:color "Blue" of myDocument, stroke color:"None"}
			set entire path of path 1 of myClickArrow to {{72, 72}, {144, 108}, {72, 144}}
		end tell
		--Set the behavior for the button.
		tell myButton
			set myGoToNextPageBehavior to make goto next page behavior with properties {behavior event:mouse up}
		end tell
		--![Button states.]
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
