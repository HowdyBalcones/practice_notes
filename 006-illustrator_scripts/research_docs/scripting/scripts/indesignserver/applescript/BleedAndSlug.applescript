--BleedAndSlug.applescript
--An InDesign Server AppleScript
--Create a new document.
tell application "InDesignServer"
	set myDocument to make document
	--The bleed and slug properties belong to the documentPreferences object.
	tell document preferences of myDocument
		--Bleed
		set document bleed bottom offset to "3p"
		set document bleed top offset to "3p"
		set document bleed inside or left offset to "3p"
		set document bleed outside or right offset to "3p"
		--Slug
		set slug bottom offset to "18p"
		set slug top offset to "3p"
		set slug inside or left offset to "3p"
		set slug right or outside offset to "3p"
	end tell
	--Save the file (fill in a valid file path on your system).
	tell application "Finder"
		set myFile to (startup disk as string) & "ServerTestFiles:myTestDocument.indd"
	end tell
	set myDocument to save myDocument to myFile
	--Close the document
	close myDocument
end tell
