--PrintPageRange.applescript
--An InDesign Server AppleScript
--Prints a page range.
--Create an example document.
tell application "InDesignServer"
	--Set up an example document.
	set myDocument to make document
	tell myDocument
		set pages per document of document preferences to 10
		set facing pages of document preferences to false
		set myPageHeight to page height of document preferences
		set myPageWidth to page width of document preferences
		--Create a single-page master spread.
		tell master spread 1
			tell page 1
				set myTextFrame to make text frame with properties {geometric bounds:{0, 0, myPageHeight, myPageWidth}, contents:auto page number}
			end tell
			set vertical justification of text frame preferences of myTextFrame to center align
			set justification of paragraph 1 of myTextFrame to center align
			set point size of character 1 of myTextFrame to 72
		end tell
		--End of example document.
		set page range of print preferences to "1-3, 10"
		print
	end tell
end tell
