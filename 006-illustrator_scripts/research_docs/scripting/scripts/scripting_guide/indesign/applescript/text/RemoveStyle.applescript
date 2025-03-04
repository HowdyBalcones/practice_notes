--RemoveStyle.applescript
--An InDesign AppleScript
--
--Shows how to remove a paragraph style.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		--Create an example document.
		set myDocument to make document
		set myPage to page 1 of myDocument
		--Create a text frame on page 1 and fill with placeholder text.
		tell myPage
			set myTextFrame to make text frame with properties {geometric bounds:my myGetBounds(myDocument, myPage), contents:placeholder text}
		end tell
		tell myDocument
			--Add a color.
			try
				set myColor to color "Red"
				--If the paragraph style does not exist, trying to get its name will generate an error.
				set myName to name of myColor
			on error
				--The paragraph style did not exist, so create it.
				set myColor to make color with properties {name:"Red", model:process, color value:{0, 100, 100, 0}}
			end try
			--Create a paragraph style named "myParagraphStyleA" if no 
			--style by that name already exists.
			try
				set myParagraphStyleA to paragraph style "myParagraphStyleA"
			on error
				--The paragraph style did not exist, so create it.
				set myParagraphStyleA to make paragraph style with properties {name:"myParagraphStyleA"}
			end try
			--At this point, the variable myParagraphStyle contains a reference to a paragraph 
			--style object, which you can now use to specify formatting.
			--Create another paragraph style.
			--Create a paragraph style named "myParagraphStyleB" if no 
			--style by that name already exists.
			try
				set myParagraphStyleB to paragraph style "myParagraphStyleB"
			on error
				--The paragraph style did not exist, so create it.
				set myParagraphStyleB to make paragraph style with properties {name:"myParagraphStyleB"}
			end try
			--Apply myParagraphStyleA to random paragraphs in the story (using the anyItem method).
			--Actually apply to even paragraphs until I find an equivalent to anyItem.
			set myStory to parent story of myTextFrame
			repeat with myParagraphCounter from 2 to (count paragraphs of myStory) by 2
				tell paragraph myParagraphCounter of myStory
					apply paragraph style using myParagraphStyleA
				end tell
			end repeat
			tell myParagraphStyleB
				set fill color to myColor
			end tell
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Remove style.]
		--Given a document "myDocment" with paragraph styles named
		--"myParagraphStyleA" and "myParagraphStyleB", remove the 
		--paragraph style "myParagraphStyleA" and replace with 
		--"myParagraphStyleB."
		tell myDocument
			delete paragraph style "myParagraphStyleA" replacing with paragraph style "myParagraphStyleB"
		end tell
		--![Remove style.]
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
