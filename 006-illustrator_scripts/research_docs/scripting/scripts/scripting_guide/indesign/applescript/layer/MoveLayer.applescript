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
		tell myDocument
			make layer
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Move layer.]
		--Given a document "myDocument" containing at least two layers...
		tell myDocument
			set myLayerA to layer 1
			set myLayerB to layer 2
			move myLayerA to after myLayerB
		end tell
		--![Move layer.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
