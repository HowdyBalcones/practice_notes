--MoveLayer.applescript
--An InDesign AppleScript
--
--Shows how to move a layer.
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
		end tell
		tell page 1 of myDocument
			set myRectangle to make rectangle with properties {geometric bounds:{72, 72, 144, 144}, stroke weight:4}
			set myOval to make oval with properties {geometric bounds:{108, 108, 180, 180}}
		end tell
		tell myDocument
			try
				set myLayer to layer "myLayer"
			on error
				set myLayer to make layer with properties {name:"myLayer"}
			end try
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myLayer to layer "myLayer" of document 1
		set myDefaultLayer to layer "Layer 1" of document 1
		--![Move layer.]
		--Given a layer "myLayer", move the layer behind the default layer.
		tell document 1
			move myLayer to end of layers of document 1
		end tell
		--![Move layer.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
