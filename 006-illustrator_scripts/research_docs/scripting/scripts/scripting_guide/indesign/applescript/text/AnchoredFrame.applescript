--AnchoredFrame.applescript
--An InDesign AppleScript
--
--Shows how to create an anchored frame.
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
		--Set the measurement units to points
		tell view preferences of myDocument
			set horizontal measurement units to points
			set vertical measurement units to points
		end tell
		tell myPage
			set myTextFrame to make text frame with properties {geometric bounds:my myGetBounds(myDocument, myPage), contents:placeholder text}
			set left indent of text 1 of myTextFrame to 72
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Anchored frame.]
		--Given a document "myDocument" with a text frame on page 1...
		set myPage to page 1 of myDocument
		set myTextFrame to text frame 1 of myPage
		tell insertion point 1 of paragraph 1 of myTextFrame
			set myInlineFrame to make text frame
		end tell
		--Recompose the text to make sure that getting the 
		--geometric bounds of the inline graphic will work.
		tell text 1 of myTextFrame to recompose
		--Get the geometric bounds of the inline frame.
		set myBounds to geometric bounds of myInlineFrame
		--Set the width and height of the inline frame. In this example, we'll
		--make the frame 24 points tall by 72 points wide.
		set e1 to item 1 of myBounds
		set e2 to item 2 of myBounds
		set e3 to (item 1 of myBounds) + 24
		set e4 to (item 2 of myBounds) + 72
		set geometric bounds of myInlineFrame to {e1, e2, e3, e4}
		set contents of myInlineFrame to "This is an inline frame."
		tell insertion point 1 of paragraph 2 of myTextFrame
			set myAnchoredFrame to make text frame
		end tell
		--Recompose the text to make sure that getting the 
		--geometric bounds of the inline graphic will work.
		tell text 1 of myTextFrame to recompose
		--Get the geometric bounds of the inline frame.
		set myBounds to geometric bounds of myAnchoredFrame
		--Set the width and height of the inline frame. In this example, we'll
		--make the frame 24 points tall by 72 points wide.
		set e1 to item 1 of myBounds
		set e2 to item 2 of myBounds
		set e3 to (item 1 of myBounds) + 24
		set e4 to (item 2 of myBounds) + 72
		set geometric bounds of myAnchoredFrame to {e1, e2, e3, e4}
		set contents of myAnchoredFrame to "This is an anchored frame."
		tell anchored object settings of myAnchoredFrame
			set anchored position to anchored
			set anchor point to top left anchor
			set horizontal reference point to anchor location
			set horizontal alignment to left align
			set anchor xoffset to 72
			set vertical reference point to line baseline
			set anchor yoffset to 24
			set anchor space above to 24
		end tell
		--![Anchored frame.]
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
