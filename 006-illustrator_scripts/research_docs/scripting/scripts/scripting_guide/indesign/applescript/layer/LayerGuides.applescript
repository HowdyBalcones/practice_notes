--LayerGuides.applescript
--An InDesign AppleScript
--
--Shows how to work with guides on a specific layer.
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
			tell page 1
				make guide with properties {location:72, orientation:horizontal}
				make guide with properties {location:144, orientation:horizontal}
				make guide with properties {location:72, orientation:vertical}
				make guide with properties {location:144, orientation:vertical}
			end tell
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		set myPage to page 1 of myDocument
		--![Layer guides.]
		--Given a document "myDocument" and a page "myPage" containing at least one guide...
		tell myDocument
			set myLayer to make layer
			--Move all of the guides on the page to the new layer.
			tell myPage
				repeat with myCounter from (count guides) to 1 by -1
					set item layer of guide myCounter to myLayer
				end repeat
			end tell
			set lock guides of myLayer to true
			set show guides of myLayer to true
		end tell
		--![Layer guides.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
