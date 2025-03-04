--ReplaceText.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Enters text in the default story and then replaces
--the text in the second paragraph.
tell application "Adobe InCopy 2024"
	set myDocument to make document
	tell story 1 of myDocument
		set contents to "Paragraph 1." & return & "Paragraph 2." & return & "Paragraph 3." & return
		--Replace the text in the second paragraph without replacing the return character
		--at the end of the paragraph.
		set myText to object reference of text from character 1 to character -2 of paragraph 2
		set contents of myText to "This text replaces the text in paragraph 2."
	end tell
end tell

