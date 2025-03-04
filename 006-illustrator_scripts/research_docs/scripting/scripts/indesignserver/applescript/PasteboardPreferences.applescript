--PasteboardPreferences.applescript
--An InDesign Server AppleScript
--Create a new document and change the size of the pasteboard.
tell application "InDesignServer"
	set myDocument to make document
	tell pasteboard preferences of myDocument
		--You can set the preview background color (which you’ll only see
		--in Preview mode) to any of the predefined UIColor constants...
		set preview background color to grass green
		--...or you can specify an array of RGB values (with values from 0 to 255)
		--set preview Background Color to {192, 192, 192}
	end tell
	--Save the file (fill in a valid file path on your system).
	tell application "Finder"
		set myFile to (startup disk as string) & "ServerTestFiles:myTestDocument.indd"
	end tell
	set myDocument to save myDocument to myFile
	--Close the document
	close myDocument
end tell
