--MoveTextBetweenDocuments.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Moves formatted text from one document to another.
tell application "Adobe InCopy 2024"
	set mySourceDocument to make document
	--Add text to the default story.
	set mySourceStory to story 1 of mySourceDocument
	set contents of mySourceStory to "This is the source text." & return & "This text is not the source text." & return
	set point size of paragraph 1 of mySourceStory to 24
	--Create a new document to move the text to.
	set myTargetDocument to make document
	set myTargetStory to story 1 of myTargetDocument
	set contents of myTargetStory to "This is the target text. Insert the source text after this paragraph." & return
	duplicate paragraph 1 of mySourceStory to after insertion point -1 of myTargetStory
end tell
