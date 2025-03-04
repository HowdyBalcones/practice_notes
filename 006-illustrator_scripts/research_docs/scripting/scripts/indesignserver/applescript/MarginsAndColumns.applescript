--MarginsAndColumns.applescript
--An InDesign Server AppleScript
--Sets up the margins and columns for the first page of an example document.
tell application "InDesignServer"
	set myDocument to make document
	tell margin preferences of page 1 of myDocument
		set columnCount to 3
		--columnGutter can be a number or a measurement string.
		set columnGutter to "1p"
		set top to "4p"
		set bottom to "6p"
		--When document.documentPreferences.facingPages = true,
		--"left" means inside "right" means outside.
		set left to "6p"
		set right to "4p"
	end tell
	--Save the file (fill in a valid file path on your system).
	tell application "Finder"
		set myFile to (startup disk as string) & "ServerTestFiles:myTestDocument.indd"
	end tell
	set myDocument to save myDocument to myFile
	--Close the document
	close myDocument
end tell
