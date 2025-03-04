--ExportPageRangeAsEPS.applescript
--An InDesign Server AppleScript.
--Exports a range of pages to series of EPS files.
--Note that the page name is not necessarily the index of the page in the
--document (e.g., the first page of a document whose page numbering starts
--with page 21 will be "21", not 1).
--Create an example document.
tell application "InDesignServer"
	set myDocument to make document
	set ruler origin of view preferences of myDocument to page origin
	set pages per document of document preferences of myDocument to 12
	set myMasterSpread to master spread 1 of myDocument
	repeat with myCounter from 1 to (count pages of myMasterSpread)
		tell page myCounter of myMasterSpread
			set myTextFrame to make text frame
			move myTextFrame by {1, 1}
		end tell
		set contents of myTextFrame to auto page number
		set point size of paragraph 1 of myTextFrame to 72
		set justification of paragraph 1 of myTextFrame to center align
		set first baseline offset of text frame preferences of myTextFrame to ascent offset
		set vertical justification of text frame preferences of myTextFrame to center align
		set geometric bounds of myTextFrame to my myGetBounds(myDocument, page myCounter of myMasterSpread)
	end repeat
	--End example document setup.
	tell EPS export preferences
		--Page range can be either all pages or a page range string.
		set page range to "1, 3-6, 7, 9-11, 12"
	end tell
	tell application "Finder"
		set myFile to (startup disk as string) & "ServerTestFiles:myTestDocument.eps"
	end tell
	export document 1 format EPS type to myFile
	close document 1
end tell
on myGetBounds(myDocument, myPage)
	tell application "InDesignServer"
		set myPageHeight to page height of document preferences of myDocument
		set myPageWidth to page width of document preferences of myDocument
		set myMarginPreferences to margin preferences of myPage
		set myTop to top of myMarginPreferences
		set myLeft to left of myMarginPreferences
		set myRight to right of myMarginPreferences
		set myBottom to bottom of myMarginPreferences
		set myRight to myPageWidth - myRight
		set myBottom to myPageHeight - myBottom
		return {myTop, myLeft, myBottom, myRight}
	end tell
end myGetBounds
