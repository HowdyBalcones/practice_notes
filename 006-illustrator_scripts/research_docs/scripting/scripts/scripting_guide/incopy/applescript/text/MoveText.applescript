--MoveText.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Create an example document.
tell application "Adobe InCopy 2024"
	set myDocument to make document
	--Create a series of paragraphs in the default story.
	set myStory to story 1 of myDocument
	set contents of myStory to "WordA" & return & "WordB" & return & "WordC" & return & "WordD" & return
	tell myStory
		--Move WordC before WordA.
		move paragraph 3 to before paragraph 1
		--Move WordB after WordD (into the same paragraph).
		move paragraph 3 to after word 1 of paragraph -1
		--Note that moving text removes it from its original location.
	end tell
end tell

