--CopyPasteText.applescript
--An InDesign AppleScript
--
--Copies text from one document and pastes it into another.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
to mySetup()
	tell application "Adobe InDesign 2024"
		--Create an example document.
		set myDocumentA to make document
		set myPageA to page 1 of myDocumentA
		set myString to "Example text." & return
		tell myPageA
			set myTextFrameA to make text frame with properties {geometric bounds:my myGetBounds(myDocumentA, myPageA), contents:myString}
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
	--![Copy paste text.]
		--Given an open document with a text frame on page 1
		set myDocumentA to document 1
		set myTextFrameA to text frame 1 of page 1 of myDocumentA
		--Create another example document.
		set myDocumentB to make document
		set myPageB to page 1 of myDocumentB
		tell myPageB
			set myTextFrameB to make text frame with properties {geometric bounds:my myGetBounds(myDocumentB, myPageB)}
		end tell
		--Make document A the active document.
		set active document to myDocumentA
		--Select the text.
		select text 1 of parent story of myTextFrameA
		copy
		--Make document B the active document.
		set active document to myDocumentB
		--Select the insertion point at which you want to paste the text.
		select insertion point -1 of myTextFrameB
		paste
	--![Copy paste text.]
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
