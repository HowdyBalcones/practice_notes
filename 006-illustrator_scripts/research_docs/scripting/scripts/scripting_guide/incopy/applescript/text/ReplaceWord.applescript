--ReplaceWord.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Enters text in the default story and then replaces
--a word in the story with a different phrase.
tell application "Adobe InCopy 2024"
	set myDocument to make document
	tell story 1 of myDocument
		set contents to "This is some example text."
		--To add more text to the story, we'll use the last insertion point
		--in the story. ("return" is a return character in AppleScript.)
		set the contents of word 3 to "a little bit of"
	end tell
end tell
