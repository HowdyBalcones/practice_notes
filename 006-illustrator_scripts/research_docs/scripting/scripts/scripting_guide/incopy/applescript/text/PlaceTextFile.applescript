--PlaceTextFile.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Places a text file in the default story of a new document.
tell application "Adobe InCopy 2024"
	set myDocument to make document
	tell story 1 of myDocument
		--Parameters for InsertionPoint.place():
		--File as File object, 
		--[ShowingOptions as Boolean = False]
		--You'll have to fill in a valid file path on your system.
		place file "yukino:test.txt" on insertion point -1 without showing options
	end tell
end tell
