--BleedSlugGuideColors.applescript
--An InDesign Server AppleScript
--Set the colors used to display the bleed and slug guides.
tell application "InDesignServer"
	set myDocument to make document
	--Set the bleed and slug properties.
	tell document preferences of myDocument
		--Bleed
		set document bleed top offset to "3p"
		set document bleed uniform size to true
		--Slug (large slug area at bottom provides room for
		--comments, tracking information, etc.)
		set slug bottom offset to "18p"
		set slug top offset to "3p"
		set slug inside or left offset to "3p"
		set slug right or outside offset to "3p"
	end tell
	tell pasteboard preferences of myDocument
		--Any of InDesign's guides can use the UIColors constants...
		set bleed guide color to cute teal
		set slug guide color to charcoal
		--...or you can specify a list of RGB values (with values from 0 to 255)
		--set bleed guide color to {0, 198, 192}
		--set slug guide color to {192, 192, 192}
	end tell
	--Save the file (fill in a valid file path on your system).
	tell application "Finder"
		set myFile to (startup disk as string) & "ServerTestFiles:myTestDocument.indd"
	end tell
	set myDocument to save myDocument to myFile
	--Close the document
	close myDocument
end tell
