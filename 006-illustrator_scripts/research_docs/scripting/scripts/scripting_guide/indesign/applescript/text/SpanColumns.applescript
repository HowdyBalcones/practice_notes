--SpanColumns.applescript
--An InDesign AppleScript
--
--Shows how to set Span/Split columns.
main()
on main()
	mySetup()
	mySnippet()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		--Create an example document.
		set myDocument to make document
		--Create a text frame on page 1.
		set myPage to page 1 of myDocument
		tell myPage
			set myBounds to my myGetBounds(myDocument, myPage)
			set myTextFrame to make text frame with properties {geometric bounds:myBounds, contents:placeholder text}
			tell myTextFrame
				set text column count of text frame preferences to 3
				set geometric bounds to {item 1 of myBounds, item 2 of myBounds, (item 3 of myBounds) * 2, item 4 of myBounds}
			end tell
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		--![Span columns.]
		set myDocument to active document
		set myPage to page 1 of myDocument
		set myTextFrame to item 1 of text frames of myPage
		tell myTextFrame
			set myStory to parent story
			tell item 1 of paragraphs of myStory
				--split column
				set span column type to split columns
				set span split column count to 2
				set split column outside gutter to 0
				set split column inside gutter to 1
			end tell
			set mySpanIndex to (count of paragraphs of myStory) div 2 + 1
			tell item mySpanIndex of paragraphs of myStory
				--span columns
				set span column type to span columns
				set span split column count to all
			end tell
		end tell
		--![Span columns.]
	end tell
end mySnippet
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
		set myY2 to (myPageHeight - myY2) / 2
		return {myY1, myX1, myY2, myX2}
	end tell
end myGetBounds
