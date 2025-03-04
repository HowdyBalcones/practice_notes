--MoveTextBetweenDocuments.applescript
--An InDesign AppleScript
--
--Moves formatted text from one document to another.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set mySourceDocument to make document
		set myPage to page 1 of mySourceDocument
		tell myPage
			set myTextFrame to make text frame with properties {geometric bounds:my myGetBounds(mySourceDocument, myPage)}
		end tell
		set mySourceStory to parent story of myTextFrame
		set contents of mySourceStory to "This is the source text." & return & "This text is not the source text." & return
		set point size of paragraph 1 of mySourceStory to 24
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set mySourceDocument to document 1
		--![Move text between documents.]
		--Given a document "mySourceDocument"...
		set mySourceStory to story 1 of mySourceDocument
		--Create a new document to move the text to.
		set myTargetDocument to make document
		set myPage to page 1 of myTargetDocument
		tell myPage
			set myTextFrame to make text frame with properties {geometric bounds:my myGetBounds(myTargetDocument, myPage)}
		end tell
		set myTargetStory to story 1 of myTargetDocument
		set contents of myTargetStory to "This is the target text. Insert the source text after this paragraph." & return
		duplicate paragraph 1 of mySourceStory to after insertion point -1 of myTargetStory
	end tell
	--![Move text between documents.]
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
