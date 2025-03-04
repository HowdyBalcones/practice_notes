--NestedStyles.applescript
--An InDesign AppleScript
--
--Shows how to create a paragraph style containing a nested style.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		tell myDocument
			set myPage to page 1
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
			tell page 1
				set myTextFrame to make text frame with properties {geometric bounds:my myGetBounds(myDocument, myPage), contents:placeholder text}
			end tell
		end tell
	end tell
end mySetup
to mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Nested styles.]
		--Given a document "myDocument"...
		--Get the last paragraph style.
		set myParagraphStyle to paragraph style -1 of myDocument
		--Get the last character style
		set myCharacterStyle to character style -1 of myDocument
		--At this point, the variable myParagraphStyle contains a reference to a paragraph 
		--style object. Next, add a nested style to the paragraph style.
		tell myParagraphStyle
			set myNestedStyle to make nested style with properties {applied character style:myCharacterStyle, delimiter:".", inclusive:true, repetition:1}
		end tell
		set myPage to page 1 of myDocument
		set myTextFrame to text frame 1 of myPage
		--Apply the paragraph style to the story so that we can see the
		--effect of the nested style we created.
		--(Note that the story object does not have the apply paragraph style method.)
		set myStory to parent story of myTextFrame
		tell text 1 of myStory
			apply paragraph style using myParagraphStyle
		end tell
		--![Nested styles.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
on myGetBounds(myDocument, myPage)
	tell application "Adobe InDesign 2024"
		tell document preferences of myDocument
			set myPageWidth to page width
			set myPageHeight to page height
		end tell
		tell margin preferences of myPage
			if side of myPage is left hand then
				set myX2 to left
				set myX1 to right
			else
				set myX1 to left
				set myX2 to right
			end if
			set myY1 to top
			set myY2 to bottom
		end tell
		set myX2 to myPageWidth - myX2
		set myY2 to myPageHeight - myY2
		return {myY1, myX1, myY2, myX2}
	end tell
end myGetBounds
