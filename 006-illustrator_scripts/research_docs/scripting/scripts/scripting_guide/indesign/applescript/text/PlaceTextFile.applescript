--PlaceTextFile.applescript
--An InDesign AppleScript
--
--Shows how to place a text file.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		--![Place text file.]
		--Given a document "myDocument"
		set myPage to page 1 of myDocument
		--Get the top and left margins to use as a place point.
		tell margin preferences of myPage
			set myX to left
			set myY to right
		end tell
		--Autoflow a text file on the current page.
		--Parameters for the place command of a page:
		--file as file or string
		--[place point as list {x, y}
		--[destination layer as layer object or string]
		--[showing options as Boolean (default is false)]
		--[autoflowing as Boolean (default is false)]
		--You'll have to fill in a valid  file path on your system.
		tell myPage
			--Note that if the PlacePoint parameter is inside a column, only the vertical (y)
			--coordinate will be honored--the text frame will expand horizontally to fit the column.
			set myStory to place alias "Macintosh HD:scripting:test.txt" place point {myX, myY} autoflowing yes without showing options
		end tell
		--![Place text file.]
	end tell
end mySnippet
to myTeardown()
end myTeardown
