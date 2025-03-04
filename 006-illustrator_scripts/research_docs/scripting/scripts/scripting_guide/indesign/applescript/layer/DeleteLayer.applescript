--DeleteLayer.applescript
--An InDesign AppleScript
--
--Shows how to delete a layer.
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
			make layer with properties {name:"Delete This Layer"}
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Delete layer.]
		--Given a document "myDocument" containing a layer named "Delete This Layer"...
		tell myDocument
			set myLayer to layer "Delete This Layer"
			tell myLayer
				delete
			end tell
		end tell
		--![Delete layer.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
