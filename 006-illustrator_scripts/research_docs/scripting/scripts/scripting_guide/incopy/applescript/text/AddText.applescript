--AddText.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Adds text to the default story.
tell application "Adobe InCopy 2024"
	set myDocument to make document
	tell story 1 of myDocument
		set contents to "This is the first paragraph of example text."
		--To add more text to the story, we'll use the last insertion point
		--in the story. ("return" is a return character in AppleScript.)
		set the contents of insertion point -1 to return & "This is the second paragraph."
	end tell
end tell

