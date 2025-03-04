--ReleaseCompoundPath.applescript
--An InDesign AppleScript
--
--Shows how to release a compound path.
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
			tell myRectangle to make compound path with myOval
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myCompoundPath to rectangle 1 of page 1 of document 1
		--![Release compound path.]
		--Given a path "myCompoundPath" (all compound paths are type Rectangle)...
		tell myCompoundPath
			set myPageItems to release compound path
		end tell
		--![Release compound path.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
