--ApplicationPageMargins.applescript
--An InDesign AppleScript
--
--Shows how to sets the application default page margins.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
end mySetup
on mySnippet()
	--Shows how to sets the application default page margins. All
	--new documents will be created using these settings. Existing
	--documents will be unaffected.
	tell application "Adobe InDesign 2024"
		--![Application page margins.]
		tell margin preferences
			--Save the current application default margin preferences.
			set myY1 to top
			set myX1 to left
			set myY2 to bottom
			set myX2 to right
			--Set the application default margin preferences.
			set top to 0
			set left to 0
			set bottom to 0
			set right to 0
		end tell
		--Create a new example document to demonstrate the change.
		set myDocument to make document
		--At this point, you can set your page size to a small width and
		--height (1x1 picas minimum).
		set page height of document preferences of myDocument to "1p"
		set page width of document preferences of myDocument to "1p"
		--Reset the application default margin preferences to their former state.
		tell margin preferences
			set top to myY1
			set left to myX1
			set bottom to myY2
			set right to myX2
		end tell
		--![Application page margins.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
