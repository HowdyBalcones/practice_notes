--MasterSpread.applescript
--An InDesign Server AppleScript
--Set up the first master spread in a new document.
tell application "InDesignServer"
	set myDocument to make document
	--Set up the document.
	tell document preferences of myDocument
		set page height to "11i"
		set page width to "8.5i"
		set facing pages to true
		set page orientation to portrait
	end tell
	--Set the document's ruler origin to page origin. This is very important--
	--if you don't do this, getting objects to the correct position on the
	--page is much more difficult.
	set ruler origin of view preferences of myDocument to page origin
	tell master spread 1 of myDocument
		--Set up the left page (verso).
		tell margin preferences of page 1
			set column count to 3
			set column gutter to "1p"
			set bottom to "6p"
			--"left" means inside, "right" means outside.
			set left to "6p"
			set right to "4p"
			set top to "4p"
		end tell
		--Add a simple footer with a section number and page number.
		tell page 1
			set myTextFrame to make text frame with properties {geometric bounds:{"61p", "4p", "62p", "45p"}}
			tell myTextFrame
				set contents of insertion point 1 to section marker
				set contents of insertion point 1 to Em space
				set contents of insertion point 1 to auto page number
				set justification of paragraph 1 to left align
			end tell
		end tell
		--Set up the right page (recto).
		tell margin preferences of page 2
			set column count to 3
			set column gutter to "1p"
			set bottom to "6p"
			--"left" means inside, "right" means outside.
			set left to "6p"
			set right to "4p"
			set top to "4p"
		end tell
		--Add a simple footer with a section number and page number.
		tell page 2
			set myTextFrame to make text frame with properties {geometric bounds:{"61p", "6p", "62p", "47p"}}
			tell myTextFrame
				set contents of insertion point 1 to auto page number
				set contents of insertion point 1 to Em space
				set contents of insertion point 1 to section marker
				set justification of paragraph 1 to right align
			end tell
		end tell
	end tell
	--Save the file (fill in a valid file path on your system).
	tell application "Finder"
		set myFile to (startup disk as string) & "ServerTestFiles:myTestDocument.indd"
	end tell
	set myDocument to save myDocument to myFile
	--Close the document
	close myDocument
end tell
