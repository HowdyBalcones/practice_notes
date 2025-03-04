--ItemLayer.applescript
--An InDesign AppleScript
--
--Shows how to change the stacking order of objects using layers.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		tell myDocument
			set horizontal measurement units of view preferences to points
			set vertical measurement units of view preferences to points
			set ruler origin of view preferences to page origin
			--Add colors.
			my myAddColor(myDocument, "DGC1_446a", process, {0, 100, 0, 50})
			my myAddColor(myDocument, "DGC1_446b", process, {100, 0, 50, 0})
			try
				set myLayer to layer "myLayer"
			on error
				set myLayer to make layer with properties {name:"myLayer"}
			end try
			set myPage to page 1
			tell page 1
				set myRectangle to make rectangle
				set geometric bounds of myRectangle to {72, 72, 144, 144}
				set myOval to make oval
				set geometric bounds of myOval to {108, 108, 180, 180}
				set fill color of myRectangle to "DGC1_446a"
				set fill color of myOval to "DGC1_446b"
			end tell
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myRectangle to rectangle 1 of page 1 of document 1
		--![Item layer.]
		--Given a rectangle "myRectangle" and an Oval "myOval"...
		--send the rectangle to the layer...
		set item layer of myRectangle to layer "myLayer" of document 1
		--![Item layer.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
on myAddColor(myDocument, myColorName, myColorModel, myColorValue)
	tell application "Adobe InDesign 2024"
		tell myDocument
			try
				set myColor to color myColorName
			on error
				set myColor to make color
			end try
			set properties of myColor to {name:myColorName, model:myColorModel, color value:myColorValue}
		end tell
	end tell
end myAddColor
