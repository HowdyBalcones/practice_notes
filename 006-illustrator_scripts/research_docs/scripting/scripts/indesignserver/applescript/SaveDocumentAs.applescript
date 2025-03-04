--SaveDocumentAs.applescript
--An InDesign Server AppleScript
--If the current document has not been saved (ever), save it.
tell application "InDesignServer"
	if (count documents) is greater than 0 then
		if saved of document 1 is false then
			--If the document has not been saved, save it to a file (fill in a valid file path on your system).
			tell application "Finder"
				set myFile to (startup disk as string) & "ServerTestFiles:myTestDocument.indd"
			end tell
			save document 1 to myFile
		end if
	else
		set result to "No documents are open."
	end if
end tell
