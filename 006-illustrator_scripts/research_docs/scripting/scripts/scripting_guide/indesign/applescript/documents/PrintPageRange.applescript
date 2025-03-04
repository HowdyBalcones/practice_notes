--PrintPageRange.applescript
--An InDesign AppleScript
--
--Prints a page range from the active document.
--The page range can be either all pages or a page range string.
--A page number in the page range must correspond to a page
--name in the document (i.e., not the page index). If the page name is
--not found, InDesign displays an error message.
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
			set pages per document of document preferences to 6
			set facing pages of document preferences to false
			set myPageHeight to page height of document preferences
			set myPageWidth to page width of document preferences
			--Create a single-page master spread.
			tell master spread 1
				repeat while (count of pages) > 1
					delete page -1
				end repeat
				tell page 1
					set myTextFrame to make text frame with properties {geometric bounds:{0, 0, myPageHeight, myPageWidth}, contents:auto page number}
				end tell
				set vertical justification of text frame preferences of myTextFrame to center align
				set justification of paragraph 1 of myTextFrame to center align
				set point size of character 1 of myTextFrame to 72
				
			end tell
		end tell
	end tell
end mySetup
on mySnippet()
	--Prints a page range from the active document.
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		![Print using page ranges.]
		tell myDocument
			--The page range can be either all pages or a page range string.
			--A page number entered in the page range must correspond to a
			--page name in the document (i.e., not the page index). If the page
			-- name is not found, InDesign will display an error message.
			set page range of print preferences to "1-3, 6"
			print without print dialog
		end tell
		--![Print using page ranges.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
