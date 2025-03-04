--SpreadAndPageGuides.applescript
--An InDesign Server AppleScript
--Demonstrates the difference between spread guides and page guides.
tell application "InDesignServer"
	set myDocument to make document
	set facing pages of document preferences of myDocument to true
	set pages per document of document preferences of myDocument to 3
	tell spread 1 of myDocument
		--Note the difference between these two guides on pages 2 and 3.
		make guide with properties {orientation:horizontal, location:"6p", fit to page:true}
		make guide with properties {orientation:horizontal, location:"9p", fit to page:false}
	end tell
	--Save the file (fill in a valid file path on your system).
	tell application "Finder"
		set myFile to (startup disk as string) & "ServerTestFiles:myTestDocument.indd"
	end tell
	set myDocument to save myDocument to myFile
	--Close the document
	close myDocument
end tell
