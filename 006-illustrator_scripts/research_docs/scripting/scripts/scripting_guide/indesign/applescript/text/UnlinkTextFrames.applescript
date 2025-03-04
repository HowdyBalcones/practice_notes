--UnlinkTextFrames.applescript
--An InDesign AppleScript
--
--Shows how to unlink text frames.
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
			--Set the ruler origin to page origin.
			set ruler origin to page origin
		end tell
		tell myPage
			--Create a text frame on the active page.
			set myTextFrameA to make text frame with properties {geometric bounds:{72, 72, 144, 144}}
			--Create another text frame on on the active page.
			set myTextFrameB to make text frame with properties {geometric bounds:{228, 72, 300, 144}}
		end tell
		--Link TextFrameA to TextFrameB using the nextTextFrame property.
		set next text frame of myTextFrameA to myTextFrameB
		--Fill the two frames with placeholder text.
		set contents of myTextFrameA to placeholder text
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		set myTextFrameA to text frame -1 of page 1 of myDocument
		--![Unlink text frames.]
		--Unlink the two text frames.
		set next text frame of myTextFrameA to nothing
		--![Unlink text frames.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
