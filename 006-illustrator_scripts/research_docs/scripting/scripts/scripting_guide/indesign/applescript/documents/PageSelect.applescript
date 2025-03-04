--PageSelect.applescript
--An InDesign AppleScript
--
--Select pages.

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
		--![Select page.]
		--Given a document with four pages (1, 2, 3, 4)...
		set myPages to pages of active document
		--Select page 2 and 3.
		select item 2 of myPages
		select item 3 of myPages existing selection add to
		--Select last page.
		select item -1 of myPages existing selection add to
		--![Select page.]
	end tell
end mySnippet

on myTeardown()
end myTeardown
