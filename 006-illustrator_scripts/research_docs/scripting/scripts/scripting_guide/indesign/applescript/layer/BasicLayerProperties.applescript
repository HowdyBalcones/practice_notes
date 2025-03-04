--BasicLayerProperties.applescript
--An InDesign AppleScript
--
--Shows how to work with basic layer properties.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		make document
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Basic layer properties.]
		--Given a document "myDocument"...
		tell myDocument
			set myLayer to make layer
			set name of myLayer to "myLayer"
			set layer color of myLayer to charcoal
			set ignore wrap of myLayer to false
			set visible of myLayer to true
		end tell
		--![Basic layer properties.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
