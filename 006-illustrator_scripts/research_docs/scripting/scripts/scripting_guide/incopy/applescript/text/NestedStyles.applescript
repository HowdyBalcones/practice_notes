--NestedStyles.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Shows how to create a paragraph style containing a nested style.
--
--Create an example document.
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
		--style object. Next, add a nested style to the paragraph style.
		tell myParagraphStyle
			set myNestedStyle to make nested style with properties {applied character style:myCharacterStyle, delimiter:".", inclusive:true, repetition:1}
		end tell
		--Apply the paragraph style to the story so that we can see the
		--effect of the nested style we created.
		--(Note that the story object does not have the applyStyle method.)
		tell story 1
			set myTextFrame to item 1 of text containers
			set contents of myTextFrame to placeholder text
			tell text 1
				apply paragraph style using myParagraphStyle
			end tell
		end tell
	end tell
end tell
