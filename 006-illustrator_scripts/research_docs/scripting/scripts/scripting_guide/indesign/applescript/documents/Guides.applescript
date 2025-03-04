--Guides.applescript
--An InDesign AppleScript
--
--Creates a series of example guides.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		make document
	end tell
end mySetup
on mySnippet()
	--Creates a series of example guides.
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Guides.]
		--Given a document "myDocument"...
		set myPage to page 1 of myDocument
		set myPageWidth to page width of document preferences of myDocument
		set myPageHeight to page height of document preferences of myDocument
		set myMarginPreferences to margin preferences of myPage
		tell myPage
			--Place guides at the margins of the page.)
			set myLeft to left of myMarginPreferences
			set myRight to right of myMarginPreferences
			set myTop to top of myMarginPreferences
			set myBottom to bottom of myMarginPreferences
			set myHeight to myPageHeight
			set myWidth to myPageWidth
			--Left and right.
			make guide with properties {orientation:vertical, location:myLeft}
			make guide with properties {orientation:vertical, location:myWidth - myRight}
			--Top and bottom.
			make guide with properties {orientation:horizontal, location:myTop}
			make guide with properties {orientation:horizontal, location:myHeight - myBottom}
			--Place a guide at the vertical center of the page.
			make guide with properties {orientation:vertical, location:myPageWidth / 2}
			--Place a guide at the horizontal center of the page.
			make guide with properties {orientation:horizontal, location:myPageHeight / 2}
		end tell
		--![Guides.]
	end tell
end mySnippet
to myTeardown()
end myTeardown
