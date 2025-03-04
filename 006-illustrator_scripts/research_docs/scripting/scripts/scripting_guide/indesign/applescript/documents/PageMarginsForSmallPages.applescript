--PageMarginsForSmallPages.applescript
--An InDesign AppleScript
--
--Shows how to avoid errors when setting margins for a small page size.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
	end tell
end mySetup
on mySnippet()
	--Shows how to avoid errors when setting margins for a small page size.
	--If you don't set the margins first, InDesign will display an error message when you
	--try to create a page size when the height of the page is less than the sum
	--of the top and bottom margins, or when the width of the page is less than the sum
	--of the inside and outside margins.
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Page margins for small pages.]
		--Given a document "myDocument"...
		set myPage to page 1 of myDocument
		--The following assumes that your document contains a single page.
		tell margin preferences of myPage
			set top to 0
			set left to 0
			set bottom to 0
			set right to 0
		end tell
		--The following prevents errors when new pages are added.
		tell margin preferences of myDocument
			set top to 0
			set left to 0
			set bottom to 0
			set right to 0
		end tell
		--The following assumes that your default master spread contains two pages.
		tell master spread 1 of myDocument
			tell margin preferences of pages
				set top to 0
				set left to 0
				set bottom to 0
				set right to 0
			end tell
		end tell
		--At this point, you can set your page size to a small width and height
		---(1x1 picas minimum).
		set page height of document preferences of myDocument to "1p"
		set page width of document preferences of myDocument to "6p"
		--![Page margins for small pages.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
