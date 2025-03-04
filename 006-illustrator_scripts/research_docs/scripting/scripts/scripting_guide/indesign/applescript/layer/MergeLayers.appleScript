--MergeLayers.applescript
--An InDesign AppleScript
--
--Shows how to merge layers.
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
		--![Merge layers.]
		--Given a document "myDocument" containing at least two layers...
		tell myDocument
			set myLayerA to layer 1
			set myLayerB to layer 2
			tell myLayerA
				merge with myLayerB
			end tell
		end tell
		--![Merge layers.]
	end tell
end mySnippet
on myTeardown()
end myTeardown