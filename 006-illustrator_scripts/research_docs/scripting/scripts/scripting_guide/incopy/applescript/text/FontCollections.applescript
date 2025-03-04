--FontCollections.applescript
--An InCopy AppleScript
--
--Shows the difference between the fonts collection of the application
--and the fonts collection of a document.
tell application "Adobe InCopy 2024"
	set myApplicationFonts to the name of every font
	set myDocument to make document
	tell myDocument
		set myStory to story 1 of myDocument
		if (count of fonts) > 0 then
			set myDocumentFonts to name of every font
		end if
	end tell
	set myString to "Document Fonts:" & return
	repeat with myCounter from 1 to (count myDocumentFonts)
		set myString to myString & (item myCounter) of myDocumentFonts & return
	end repeat
	set myString to myString & return & "Application Fonts:" & return
	repeat with myCounter from 1 to (count myApplicationFonts)
		set myString to myString & (item myCounter) of myApplicationFonts & return
	end repeat
	set contents of myStory to myString
end tell
