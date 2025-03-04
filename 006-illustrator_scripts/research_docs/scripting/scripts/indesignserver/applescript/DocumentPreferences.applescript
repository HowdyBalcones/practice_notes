--DocumentPreferences.applescript
--An InDesign Server AppleScript
--Use the documentPreferences object to change the
--dimensions and orientation of the document.
tell application "InDesignServer"
	if (count documents) is greater than 0 then
		set myDocument to document 1
		tell document preferences of myDocument
			set page height to "800pt"
			set page width to "600pt"
			set page orientation to landscape
			set pages per document to 16
		end tell
		--Save the file (fill in a valid file path on your system).
		tell application "Finder"
			set myFile to (startup disk as string) & "ServerTestFiles:myTestDocument.indd"
		end tell
		set myDocument to save myDocument to myFile
		--Close the document
		close myDocument
	else
		set result to "No documents are open."
	end if
end tell
