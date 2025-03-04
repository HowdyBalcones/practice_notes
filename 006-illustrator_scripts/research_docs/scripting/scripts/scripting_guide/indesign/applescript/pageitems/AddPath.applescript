--AddPath.applescript
--An InDesign AppleScript
--
--Shows how to use the add path method.
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
			set ruler origin of view preferences to page origin
			set myPage to page 1
			tell page 1
				set myRectangle to make rectangle
				set geometric bounds of myRectangle to {72, 72, 144, 144}
				set myOval to make oval
				set geometric bounds of myOval to {108, 108, 180, 180}
			end tell
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myRectangle to rectangle 1 of page 1 of document 1
		set myOval to oval 1 of page 1 of document 1
		--![Add path.]
		--Given a rectangle "myRectangle" and an Oval "myOval"...
		tell myRectangle to add path with myOval
		--![Add path.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
