--PageReframe.applescript
--An InDesign AppleScript
--
--Resize pages by reframe method.

main()

on main()
	mySetup()
	mySnippet()
	myTeardown()
end main

on mySetup()
	tell application "Adobe InDesign 2024"
		--Create a new document.
		set myDocument to make document
		tell view preferences of myDocument
			set horizontal measurement units to points
			set vertical measurement units to points
		end tell
		--Create another 3 pages.
		tell myDocument
			repeat with i from 2 to 4
				make page
			end repeat
		end tell
	end tell
end mySetup

on mySnippet()
	tell application "Adobe InDesign 2024"
		--![Reframe page.]
		--Given a document with four pages (1, 2, 3, 4)...
		tell item 2 of pages of active document
			--Make the page one inch wider and one inch higher.
			set myBounds to bounds
			set myY1 to item 1 of myBounds
			set myX1 to item 2 of myBounds
			set myY2 to (item 3 of myBounds) + 72
			set myX2 to (item 4 of myBounds) + 72
			reframe in inner coordinates opposing corners {{myX1, myY1}, {myX2, myY2}}
		end tell
		--![Reframe page.]
	end tell
end mySnippet

on myTeardown()
end myTeardown
