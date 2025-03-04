--LockLayersBelow.applescript
--An InDesign AppleScript
--
--Shows how to lock all layers below the active layer.
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
		--![Lock layers.]
		--Given a document "myDocument"...
		tell myDocument
			set myLayer to active layer
			repeat with myCounter from ((index of myLayer) + 1) to (count layers)
				set locked of layer myCounter to true
			end repeat
		end tell
		--![Lock layers.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
