--LayerName.applescript
--An InDesign AppleScript
--
--Shows how to get a reference to a layer by name.
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
		--![Layer name.]
		--Given a document "myDocument"...
		tell myDocument
			set myLayer to layer "Text Layer"
			display dialog ("Text Layer ID: " & id of myLayer)
		end tell
		--![Layer name.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
