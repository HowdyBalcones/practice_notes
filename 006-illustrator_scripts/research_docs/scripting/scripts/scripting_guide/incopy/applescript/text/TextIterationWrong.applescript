--TextIterationWrong.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Shows how *not* to iterate through text.
tell application "Adobe InCopy 2024"
	set myDocument to make document
	set myString to "Paragraph 1." & return
	set myString to myString & "Delete this paragraph." & return
	set myString to myString & "Paragraph 2." & return
	set myString to myString & "Paragraph 3." & return
	set myString to myString & "Paragraph 4." & return
	set myString to myString & "Paragraph 5." & return
	set myString to myString & "Delete this paragraph." & return
	set myString to myString & "Paragraph 6." & return
	set myStory to story 1 of myDocument
	set contents of myStory to myString
	--The following for loop will fail to format all of the paragraphs 
	--and then generate an error.
	repeat with myParagraphCounter from 1 to (count paragraphs of myStory)
		if contents of word 1 of paragraph myParagraphCounter of myStory is "Delete" then
			tell paragraph myParagraphCounter of myStory to delete
		else
			set point size of paragraph myParagraphCounter of myStory to 24
		end if
	end repeat
end tell
