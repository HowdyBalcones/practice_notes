--ApplicationPageMargins.applescript
--An InDesign Server AppleScript
--Sets the application default page margins. All new documents will be created using 
--these settings. Existing documents will be unaffected.
tell application "InDesignServer"
	tell margin preferences
		--Save the current application default margin preferences.
		set myY1 to top
		set myX1 to left
		set myY2 to bottom
		set myX2 to right
		--Set the application default margin preferences.
		set top to 0
		set left to 0
		set bottom to 0
		set right to 0
	end tell
	
	--Create a new example document to demonstrate the change.
	set myDocument to make document
	set page height of document preferences of myDocument to "1p"
	set page width of document preferences of myDocument to "6p"
	
	--Save the file (fill in a valid file path on your system).
	tell application "Finder"
		set myFile to (startup disk as string) & "ServerTestFiles:myTestDocument.indd"
	end tell
	set myDocument to save myDocument to myFile
	
	--Close the document
	close myDocument
	
	--Reset the application default margin preferences to their former state.
	tell margin preferences
		set top to myY1
		set left to myX1
		set bottom to myY2
		set right to myX2
	end tell
end tell
