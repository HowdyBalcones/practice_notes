--CopyUnformattedText.applescript
--An InDesign AppleScript
--
--Shows how to remove formatting from text as you move it to other locations in a document.
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
	end tell
end mySetup
on mySnippet()
	--![Copy unformatted text.]
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		set myPage to page 1 of myDocument
		tell myPage
			set myTextFrameA to make text frame with properties {geometric bounds:{72, 72, 144, 288}}
			set contents of myTextFrameA to "This is a formatted string."
			set font style of text 1 of parent story of myTextFrameA to "Bold"
			set myTextFrameB to make text frame with properties {geometric bounds:{228, 72, 300, 288}}
			set contents of myTextFrameB to "This is the destination text frame. Text pasted here will retain its formatting."
			set font style of text 1 of myTextFrameB to "Italic"
		end tell
		--Copy from one frame to another using a simple copy.
		select text 1 of myTextFrameA
		copy
		select insertion point -1 of myTextFrameB
		paste
		--Create another text frame on the active page.
		tell myPage
			set myTextFrameC to make text frame with properties {geometric bounds:{312, 72, 444, 288}}
		end tell
		set contents of myTextFrameC to "Text copied here will take on the formatting of the existing text."
		set font style of text 1 of parent story of myTextFrameC to "Italic"
		--Copy the unformatted string from text frame A to the end of text frame C (note
		--that this doesn't really copy the text it replicates the text string from one
		--text frame in another text frame):
		set contents of insertion point -1 of myTextFrameC to contents of text 1 of parent story of myTextFrameA
	end tell
	--![Copy unformatted text.]
end mySnippet
on myTeardown()
end myTeardown
