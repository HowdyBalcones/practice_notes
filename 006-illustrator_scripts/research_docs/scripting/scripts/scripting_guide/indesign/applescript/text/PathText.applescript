--PathText.applescript
--An InDesign AppleScript
--
--Shows how to add text to a path.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		--Set the measurement units to points
		tell view preferences of myDocument
			set horizontal measurement units to points
			set vertical measurement units to points
			--Set the ruler origin to page origin.
			set ruler origin to page origin
		end tell
		tell page 1 of myDocument
			--Create a rectangle on the first page.
			set myRectangle to make rectangle with properties {geometric bounds:{72, 72, 288, 288}}
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Path text.]
		--Given a document "myDocument" with a rectangle on page 1...
		set myRectangle to rectangle 1 of page 1 of myDocument
		tell myRectangle
			set myTextPath to make text path with properties {contents:"This is path text."}
		end tell
		--![Path text.]
	end tell
end mySnippet
to myTeardown()
end myTeardown
