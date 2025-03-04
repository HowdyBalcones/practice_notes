--ActiveLayer.applescript
--An InDesign AppleScript
--
--Shows how to get a reference to the active layer.
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
			repeat with myCounter from 1 to 10
				make layer
			end repeat
			set active layer to layer 5
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Add active layer.]
		--Given a document "myDocument"...
		tell myDocument
			set myLayer to active layer
			display dialog ("Active layer: " & name of myLayer)
		end tell
		--![Add active layer.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
