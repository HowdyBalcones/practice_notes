--ExportPageRangeAsEPS.applescript
--An InDesign AppleScript
--
--Exports specified pages of An InDesign document to an EPS
--using the current EPS export settings.
main()
to main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	--Creates a new document.
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		set myDesktopFolder to path to desktop as string
		set myFile to myDesktopFolder & "ExportPageRangeAsEPS.indd"
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
			set myDocument to save to myFile
		end tell
	end tell
end mySetup
to mySnippet()
	tell application "Adobe InDesign 2024"
		--![Export page range to EPS.]
		set myDesktopFolder to path to desktop as string
		set myFile to myDesktopFolder & "ExportPageRangeAsEPS.eps"
		tell EPS export preferences
			--Enter the names of the pages you want to export in the following line.
			--Note that the page name is not necessarily the index of the page in
			--the document (e.g., the first page of a document whose page numbering
			--starts with page 21 will be "21", not 1).
			set page range to "1, 3,6"
		end tell
		tell document 1
			export format EPS type to myFile without showing options
		end tell
		--![Export page range to EPS.]
	end tell
end mySnippet
to myTeardown()
end myTeardown
