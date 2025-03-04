--MakeDocument.applescript
--An InDesign Server AppleScript
--Creates a new document.
tell application "InDesignServer"
	set myDocument to make document
	--Save the file (fill in a valid file path on your system).
	tell application "Finder"
		set myFile to (startup disk as string) & "ServerTestFiles:myTestDocument.indd"
	end tell
	set myDocument to save myDocument to myFile
	--Close the document
	close myDocument
end tell
