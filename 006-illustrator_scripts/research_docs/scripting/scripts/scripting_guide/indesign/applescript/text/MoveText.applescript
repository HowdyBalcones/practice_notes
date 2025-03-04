--MoveText.applescript
--An InDesign AppleScript
--
--Move text between text frames.
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
		--Set the bounds live area of the page.
		set myBounds to my myGetBounds(myDocument, myPage)
		set {myY1, myX1, myY2, myX2} to myBounds
		set myWidth to myX2 - myX1
		set myHeight to myY2 - myY1
		--Create a series of text frames.
		tell myPage
			set myTextFrameA to make text frame with properties {geometric bounds:{myY1, myX1, myY1 + (myHeight / 2), myX1 + (myWidth / 2)}, contents:"Before." & return}
			set myTextFrameB to make text frame with properties {geometric bounds:{myY1, myX1 + (myWidth / 2), myY1 + (myHeight / 2), myX2}, contents:"After." & return}
			set myTextFrameC to make text frame with properties {geometric bounds:{myY1 + (myHeight / 2), myX1, myY2, myX1 + (myWidth / 2)}, contents:"Between characters" & return}
			set myTextFrameD to make text frame with properties {geometric bounds:{myY1 + (myHeight / 2), myX1 + (myWidth / 2), myY2, myX2}, contents:"Text to move:" & return & "WordA" & return & "WordB" & return & "WordC" & return}
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Move text.]
		--Given a document myDocument" with four text frams on page 1...
		set myTextFrameA to text frame 4 of page 1 of myDocument
		set myTextFrameB to text frame 3 of page 1 of myDocument
		set myTextFrameC to text frame 2 of page 1 of myDocument
		set myTextFrameD to text frame 1 of page 1 of myDocument
		--Note that moving text removes it from its original location.
		tell parent story of myTextFrameD
			--Move WordC between the words in TextFrameC.
			move paragraph 4 to before word -1 of paragraph 1 of parent story of myTextFrameC
			--Move WordB after the word in TextFrameB.
			move paragraph 3 to after insertion point -1 of myTextFrameB
			--Move WordA to before the word in TextFrameA.
			move paragraph 2 to before word 1 in myTextFrameA
		end tell
	end tell
	--![Move text.]
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
