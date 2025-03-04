--ExportTextFile.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Creates a story in an example document and then exports the text to a text file.
tell application "Adobe InCopy 2024"
	set myDocument to make document
	set myStory to story 1 of myDocument
	--Fill the story with placeholder text.
	set myTextFrame to item 1 of text containers of myStory
	set contents of myTextFrame to placeholder text
	--Text export method parameters:
	--format as enumeration
	--to alias as string
	--showing options boolean 
	--version comments string 
	--force save boolean 
	--Format parameter can be:
	--rtf
	--tagged text
	--text type
	--Export the story as text. You'll have to fill in a valid file path on your system.
	tell myStory
		export to "yukino:test.txt" format text type
	end tell
end tell

