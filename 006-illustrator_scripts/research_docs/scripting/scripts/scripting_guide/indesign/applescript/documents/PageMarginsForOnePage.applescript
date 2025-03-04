--PageMarginsForOnePage.applescript
--An InDesign AppleScript
--
--Shows how to set page margins for a single page.
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
	--Shows how to set page margins for a single page.
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Page margins for one page.]
		--Given a document "myDocument"...
		set myPage to page 1 of myDocument
		tell margin preferences of myPage
			set column count to 3
			--column gutter can be a number or a measurement string.
			set column gutter to "1p"
			set top to "4p"
			set bottom to "6p"
			--When facingPages of document preferences of myDocument is true,
			--"left" means inside and "right" means outside.
			set left to "6p"
			set right to "4p"
		end tell
		--![Page margins for one page.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
