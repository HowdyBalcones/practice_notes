--CreateStyles.applescript
--An InCopy AppleScript
--
--Shows how to create and apply a paragraph style and a character style.
tell application "Adobe InCopy 2024"
	--Create an example document.
	set myDocument to make document
	tell myDocument
		--Create a color for use by one of the paragraph styles we'll create.
		try
			set myColor to color "Red"
		on error
			--The color did not exist, so create it.
			set myColor to make color with properties {name:"Red", model:process, color value:{0, 100, 100, 0}}
		end try
		set myStory to story 1
		set contents of myStory to "Normal text. Text with a character style applied to it. More normal text."
		--Create a character style named "myCharacterStyle" if 
		--no style by that name already exists.
		try
			set myCharacterStyle to character style "myCharacterStyle"
		on error
			--The style did not exist, so create it.
			set myCharacterStyle to make character style with properties {name:"myCharacterStyle"}
		end try
		--At this point, the variable myCharacterStyle contains a reference to a character 
		--style object, which you can now use to specify formatting.
		set fill color of myCharacterStyle to myColor
		--Create a paragraph style named "myParagraphStyle" if 
		--no style by that name already exists.
		try
			set myParagraphStyle to paragraph style "myParagraphStyle"
		on error
			--The paragraph style did not exist, so create it.
			set myParagraphStyle to make paragraph style with properties {name:"myParagraphStyle"}
		end try
		--At this point, the variable myParagraphStyle contains a reference to a paragraph 
		--style object, which you can now use to specify formatting.
		--(Note that the story object does not have the apply paragraph style method.)
		tell text 1 of story 1
			apply paragraph style using myParagraphStyle
			tell text from character 13 to character 54
				apply character style using myCharacterStyle
			end tell
		end tell
	end tell
end tell
