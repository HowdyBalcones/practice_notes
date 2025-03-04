--Guides.applescript
--An InDesign Server AppleScript
--Create a new document, add guides, and set guide properties.
tell application "InDesignServer"
	set myDocument to make document
	set myPageWidth to page width of document preferences of myDocument
	set myPageHeight to page height of document preferences of myDocument
	tell page 1 of myDocument
		set myMarginPreferences to margin preferences
		--Place guides at the margins of the page.
		make guide with properties {orientation:vertical, location:left of myMarginPreferences}
		make guide with properties {orientation:vertical, location:right of myMarginPreferences}
		make guide with properties {orientation:horizontal, location:top of myMarginPreferences}
		make guide with properties {orientation:horizontal, location:bottom of myMarginPreferences}
		--Place a guide at the vertical center of the page.
		make guide with properties {orientation:vertical, location:myPageWidth / 2}
		--Place a guide at the horizontal center of the page.
		make guide with properties {orientation:horizontal, location:myPageHeight / 2}
	end tell
	--Save the file (fill in a valid file path on your system).
	tell application "Finder"
		set myFile to (startup disk as string) & "ServerTestFiles:myTestDocument.indd"
	end tell
	set myDocument to save myDocument to myFile
	--Close the document
	close myDocument
end tell
