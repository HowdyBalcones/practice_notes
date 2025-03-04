--SimpleButton.applescript
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
		set myPage to page 1 of myDocument
		--![Simple button.]
		--Given a page "myPage" and a document containing the color "Red"...
		--Make a button by converting a page item.
		tell myPage
			set myRightArrow to make polygon with properties {fill color:"Red", name:"GoToNextPageButton"}
			set entire path of path 1 of myRightArrow to {{72, 72}, {144, 108}, {72, 144}}
			set myButton to make button with properties {geometric bounds:{72, 72, 144, 144}}
		end tell
		tell state 1 of myButton
			add items to state pageitems {myRightArrow}
		end tell
		tell myButton
			set myGoToNextPageBehavior to make goto next page behavior with properties {behavior event:mouse up}
		end tell
		--![Simple button.]
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
