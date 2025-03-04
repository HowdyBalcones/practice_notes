--ApplyMaster.applescript
--An InDesign Server AppleScript
--Applies a master spread to a page.
tell application "InDesignServer"
	set myDocument to make document
	--Create a new master spread.
	tell myDocument
		set myMasterSpread to make master spread
	end tell
	--Apply the new master spread to the first page in the document.
	set applied master of page 1 of myDocument to myMasterSpread
	--When you are working with an existing document, you can refer to
	--a master spread by name, for example: myDocument.MasterSpreads.Item("B-Master")

	--Save the file (fill in a valid file path on your system).
	tell application "Finder"
		set myFile to (startup disk as string) & "ServerTestFiles:myTestDocument.indd"
	end tell
	set myDocument to save myDocument to myFile

	--Close the document
	close myDocument
end tell
