--PageTransitions.applescript
--An InDesign AppleScript
--
--Shows how to apply page transition options to a spread in an exported PDF document.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		tell view preferences of myDocument
			set horizontal measurement units to points
			set vertical measurement units to points
			set ruler origin to page origin
		end tell
		tell document preferences of myDocument
			set pages per document to 12
			set facing pages to false
			set myPageWidth to page width
			set myPageHeight to page height
		end tell
		--If the master spread contains more than a single
		--page, delete the additional pages.
		set myMasterSpread to master spread 1 of myDocument
		if (count pages of myMasterSpread) is greater than 1 then
			repeat with myCounter from 2 to (count pages of myMasterSpread)
				delete page myCounter of myMasterSpread
			end repeat
		end if
		tell page 1 of myMasterSpread
			set myTextFrame to make text frame with properties {geometric bounds:{0, 0, myPageHeight, myPageWidth}, contents:auto page number}
		end tell
		set vertical justification of text frame preferences of myTextFrame to center align
		set point size of text 1 of parent story of myTextFrame to 72
		set justification of text 1 of parent story of myTextFrame to center align
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Page transitions.]
		--Given a document "myDocument" containing at least two spreads...
		repeat with myCounter from 1 to (count spreads of myDocument)
			set page transition type of spread myCounter of myDocument to page turn transition
			--This page transition option does not support the page transition direction options
			--or page transition duration properties. If you chose wipe transition (for example), 
			--you would be able to set those options, as shown in the next two lines:
			--set page transition direction options of spread myCounter of myDocument to left to right
			--set page transition duration of spread myCounter of myDocument to medium
		end repeat
		--![Page transitions.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
