--HideOtherLayers.applescript
--An InDesign AppleScript
--
--Shows how to refer to layers by their index.
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
		--![Refer to layer by layer index.]
		--Given a document "myDocument"...
		tell myDocument
			set myTargetLayer to active layer
			set myLayerName to name of myTargetLayer
			repeat with myCounter from 1 to (count layers)
				set myName to name of layer myCounter
				if myName is not equal to myLayerName then
					set visible of layer myCounter to false
				end if
			end repeat
		end tell
		--![Refer to layer by layer index.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
