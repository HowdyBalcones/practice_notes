--SpceicalCharacters.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Shows how to enter special characters in text.
tell application "Adobe InCopy 2024"
	set myDocument to make document
	set myStory to story 1 of myDocument
	--Entering special characters directly:
	set contents of myStory to "Registered trademark: �" & return & "Copyright:  �" & return & "Trademark: �" & return
	--Entering special characters by their Unicode glyph ID value:
	set contents of insertion point -1 of myStory to "Not equal to: <2260>" & return
	set contents of insertion point -1 of myStory to "Square root: <221A>" & return
	set contents of insertion point -1 of myStory to "Square root: <00B6>" & return
	--Entering InCopy special characters by tehir enumerations:
	set contents of insertion point -1 of myStory to "Automatic page number marker: "
	set contents of insertion point -1 of myStory to auto page number
	set contents of insertion point -1 of myStory to return & "Section symbol: "
	set contents of insertion point -1 of myStory to section symbol
	set contents of insertion point -1 of myStory to return & "En dash: "
	set contents of insertion point -1 of myStory to En dash
	set contents of insertion point -1 of myStory to return
end tell


