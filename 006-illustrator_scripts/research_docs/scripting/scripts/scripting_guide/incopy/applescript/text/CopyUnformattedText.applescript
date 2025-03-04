--CopyUnformattedText.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Shows how to remove formatting from text as you move it to other locations in a document.
--Create an example document.
tell application "Adobe InCopy 2024"
	set myDocument to make document
	set myStory to story 1 of myDocument
	set myString to "This is a formatted string." & return & "Text pasted after this text will retain its formatting."
	set myString to myString & "Text moved to the following line will take on the formatting of the insertion point." & return
	set myString to myString & "Italic: "
	set contents of myStory to myString
	--Apply formatting to the first paragraph.
	set font style of paragraph 1 of myStory to "Bold"
	--Apply formatting to the last paragraph.
	set font style of paragraph -1 of myStory to "Italic"
	--Copy from one frame to another using a simple copy.
	select word 1 of paragraph 1 of myStory
	copy
	select insertion point -2 of paragraph 2 of myStory
	paste
	--Copy the unformatted string from the first word to the end of the story
	--by getting and setting the contents of text objects. Note that this doesn't 
	--really copy the text it replicates the text string from one text location
	--to another.
	set contents of insertion point -1 of myStory to contents of word 1 of paragraph 1 of myStory
end tell

