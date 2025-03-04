--MakeLayer.applescript
--An InDesign AppleScript
--
--Shows how to create a new layer.
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
		tell myDocument
			set myLayer to make layer
		end tell
	end tell
end mySnippet
on myTeardown()
end myTeardown
