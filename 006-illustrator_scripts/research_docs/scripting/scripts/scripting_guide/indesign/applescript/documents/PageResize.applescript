--PageResize.applescript
--An InDesign AppleScript
--
--Resize pages.

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
		--![Resize page.]
		--Given a document with four pages (1, 2, 3, 4)...
		tell pages of active document
			--Resize page to two times bigger
			resize item 2 in inner coordinates from center anchor by multiplying current dimensions by values {2, 2}
			--Resize page to 400 points width and 600 points height.
			resize item 3 in inner coordinates from center anchor by replacing current dimensions with values {400, 600}
		end tell
		--![Resize page.]
	end tell
end mySnippet

on myTeardown()
end myTeardown
