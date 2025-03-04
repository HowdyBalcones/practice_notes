--DuplicateLayer.applescript
--An InDesign AppleScript
--
--Shows how to duplicate a layer.
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
			make layer with properties {name:"Text Layer"}
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Duplicate layer.]
		--Given a document "myDocument"...		
		tell myDocument
			set myLayer to layer 1
			tell myLayer
				set myLayer1 to duplicate
			end tell
		end tell
		--![Duplicate layer.]	
	end tell
end mySnippet
on myTeardown()
end myTeardown
