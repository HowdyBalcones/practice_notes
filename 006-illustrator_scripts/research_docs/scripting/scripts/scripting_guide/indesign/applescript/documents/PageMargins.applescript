--PageMargins.applescript
--An InDesign AppleScript
--
--Shows how to set the margins of a document.
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
			tell document preferences
				set page width to "40p"
				set page height to "60p"
				set facing pages to true
			end tell
		end tell
	end tell
end mySetup
on mySnippet()
	--Shows how to set the margins of a document.
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Setting page margins and columns.]
		--Given a document "myDocument"...
		tell view preferences of myDocument
			set horizontal measurement units to points
			set vertical measurement units to points
		end tell
		set myPage to page 1 of myDocument
		tell margin preferences of myPage
			set top to 56
			set bottom to 24
			--When facingPages of document preferences of myDocument is true,
			--"left" means inside and "right" means outside.
			set left to 48
			set right to 10
		end tell
		--The following applies to new pages when they are added.
		tell margin preferences of myDocument
			set top to 56
			set bottom to 24
			set left to 48
			set right to 10
		end tell
		--The following works on all pages of your default master spread.
		tell master spread 1 of myDocument
			tell margin preferences of pages
				set top to 56
				set bottom to 24
				set left to 48
				set right to 10
			end tell
		end tell
		--![Setting page margins and columns.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
