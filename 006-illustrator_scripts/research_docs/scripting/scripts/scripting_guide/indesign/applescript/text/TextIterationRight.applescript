--TextIterationRight.applescript
--An InDesign AppleScript
--
--Shows how to iterate through text.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		set myPage to page 1 of myDocument
		tell myPage
			set myTextFrame to make text frame with properties {geometric bounds:my myGetBounds(myDocument, myPage)}
		end tell
		set myString to "Paragraph 1." & return
		set myString to myString & "Delete this paragraph." & return
		set myString to myString & "Paragraph 2." & return
		set myString to myString & "Paragraph 3." & return
		set myString to myString & "Paragraph 4." & return
		set myString to myString & "Paragraph 5." & return
		set myString to myString & "Delete this paragraph." & return
		set myString to myString & "Paragraph 6" & return
		set contents of myTextFrame to myString
		set myStory to parent story of myTextFrame
		set contents of myStory to myString
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		set myStory to story 1 of myDocument
		--![Text iteration right.]
		--By iterating backwards we can avoid the error.
		repeat with myParagraphCounter from (count paragraphs of myStory) to 1 by -1
			if contents of word 1 of paragraph myParagraphCounter of myStory is "Delete" then
				tell paragraph myParagraphCounter of myStory to delete
			else
				set point size of paragraph myParagraphCounter of myStory to 24
			end if
		end repeat
		--![Text iteration right.]
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
