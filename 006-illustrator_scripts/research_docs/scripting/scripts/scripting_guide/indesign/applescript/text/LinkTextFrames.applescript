--LinkTextFrames.applescript
--An InDesign AppleScript
--
--Shows how to link text frames.
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
		tell page 1 of myDocument
			--Create a text frame on the active page.
			set myTextFrameA to make text frame with properties {geometric bounds:{72, 72, 144, 144}}
			--Create another text frame on a new page.
			set myTextFrameB to make text frame with properties {geometric bounds:{228, 72, 300, 144}}
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Link text frames.]
		--Given a document "myDocument" with two unlinked text frames on page 1...
		set myTextFrameA to text frame 2 of page 1 of document 1
		set myTextFrameB to text frame 1 of page 1 of document 1
		--Link TextFrameA to TextFrameB using the next text frame property.
		set next text frame of myTextFrameA to myTextFrameB
		--Add a page.
		tell myDocument
			set myNewPage to make page
		end tell
		--Create another text frame on the new page.
		tell myNewPage
			set myTextFrameC to make text frame with properties {geometric bounds:{72, 72, 144, 144}}
			--Link TextFrameC to TextFrameB using the previousTextFrame property.
			set previous text frame of myTextFrameC to myTextFrameB
			--Fill the text frames with placeholder text.
			set contents of myTextFrameA to placeholder text
		end tell
		--![Link text frames.]
	end tell
end mySnippet
on myTeardown()
end myTeardown

