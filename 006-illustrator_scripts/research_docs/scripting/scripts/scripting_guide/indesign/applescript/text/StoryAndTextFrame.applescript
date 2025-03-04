--StoriesAndTextFrames.applescript
--An InDesign AppleScript
--
--Shows that overset text is not included in the
--contents of a text frame.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		--Set the measurement units to points
		tell view preferences of myDocument
			set horizontal measurement units to points
			set vertical measurement units to points
			--Set the ruler origin to page origin.
			set ruler origin to page origin
		end tell
		set myPage to page 1 of myDocument
		tell myPage
			set myTextFrame to make text frame with properties {geometric bounds:{72, 72, 96, 288}, contents:placeholder text}
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Stories and text frames.]
		--Given a document "myDocument" with a text frame on page 1...
		set myTextFrame to text frame 1 of myDocument
		--Now add text beyond the end of the text frame.
		set myString to return & "This is some overset text"
		tell insertion point -1 of myTextFrame to set contents to myString
		set myString to contents of text 1 of myTextFrame
		display dialog ("The last paragraph in this dialog should be \"This is some overset text\". Is it?" & return & myString)
		set myString to contents of parent story of myTextFrame
		display dialog ("The last paragraph in this alert should be \"This is some overset text\". Is it?" & return & myString)
		--![Stories and text frames.]
	end tell
end mySnippet
to myTeardown()
end myTeardown
