--ExportTextRange.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Creates a story in an example document and then exports 
--some of the text to a text file.
tell application "Adobe InCopy 2024"
	set myDocument to make document
	set myStory to story 1 of myDocument
	--Fill the story with placeholder text.
	set myTextFrame to item 1 of text containers of myStory
	set contents of myTextFrame to placeholder text
	set myStartCharacter to index of character 1 of paragraph 1 of myStory
	set myEndCharacter to the index of last character of paragraph 1 of myStory
	set myText to object reference of text from character myStartCharacter to character myEndCharacter of myStory
	--Export the text range. You'll have to fill in a valid file path on your system.
	tell myText to export to "yukino:test.txt" format text type
end tell

