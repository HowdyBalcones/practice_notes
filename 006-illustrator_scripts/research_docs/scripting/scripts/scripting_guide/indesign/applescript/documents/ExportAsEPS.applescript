--ExportAsEPS.applescript
--An InDesign AppleScript
--
--Exports all of the pages in the active document to a series of EPS files
--(an EPS, by definition, can contain only a single page).
main()
to main()
	mySetup()
	mySnippet()
	myTeardown()
end main
to mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		set myDesktopFolder to path to desktop as string
		set myFile to myDesktopFolder & "ExportAsEPS.indd"
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
	--![Export to EPS.]
	--Exports all of the pages in the active document to a series of EPS files
	--(an EPS, by definition, can contain only a single page).
	set myDesktopFolder to path to desktop as string
	set myFile to myDesktopFolder & "ExportAsEPS.eps"
	tell application "Adobe InDesign 2024"
		set page range of EPS export preferences to all pages
		tell document 1
			export format EPS type to myFile without showing options
		end tell
	end tell
	--![Export to EPS.]
end mySnippet
to myTeardown()
end myTeardown
