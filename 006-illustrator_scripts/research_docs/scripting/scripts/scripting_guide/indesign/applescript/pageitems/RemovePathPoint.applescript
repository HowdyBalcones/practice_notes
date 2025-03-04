--RemovePathPoint.applescript
--An InDesign AppleScript
--
--Shows how to remove a point from a path.
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
				set myGraphicLine to make graphic line
				set anchor of path point 1 of path 1 of myGraphicLine to {72, 72}
				set anchor of path point 2 of path 1 of myGraphicLine to {72, 144}
			end tell
			tell path 1 of myGraphicLine
				set myPathPoint to make path point
			end tell
			--Move the path point to a specific location.
			set anchor of myPathPoint to {144, 144}
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		set myPage to page 1 of myDocument
		set myGraphicLine to page item 1 of myPage
		--<fragment>
		--Given a graphic line "myGraphicLine"...
		tell path 1 of myGraphicLine
			delete path point -1
		end tell
		--</fragment>	
	end tell
end mySnippet
on myTeardown()
end myTeardown
