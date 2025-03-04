--PersistedTextFrameFill.applescript
--An InDesign AppleScript
--
--Shows how to set rules on a text frame to determine how it grows when the user inputs text. 
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
--<setup>
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		set myPage to page 1 of myDocument
		tell myPage
			tell view preferences of myDocument
				set horizontal measurement units to points
				set vertical measurement units to points
				--Set the ruler origin to page origin.
				set ruler origin to page origin
			end tell
			set myTextFrame to make text frame with properties {geometric bounds:{72, 72, 96, 288}, contents:placeholder text}
			set myTextFrame2 to make text frame with properties {geometric bounds:{156, 72, 180, 288}, contents:placeholder text}
			set myTextFrame3 to make text frame with properties {geometric bounds:{230, 72, 254, 288}, contents:placeholder text}
			set myTextFrame4 to make text frame with properties {geometric bounds:{304, 72, 328, 288}, contents:placeholder text}
		end tell
	end tell
end mySetup
--</setup>
--<snippet>
on mySnippet()
	--![Persisted text frame fill.]
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		set myPage to page 1 of myDocument
		tell myPage
			set myTextFrame to text frame 4 of myPage
			--Now add text at the end of the text frame.
			set myString to return & "this is some overset text"
			tell insertion point -1 of myTextFrame to set contents to myString
			set myString to contents of text 1 of myTextFrame
			display dialog ("The last paragraph in this alert should be \"This is some overset text\". Is it?" & return & myString)
			set myString to contents of parent story of myTextFrame
			display dialog ("The last paragraph in this alert should be \"This is some overset text\". Is it?" & return & myString)
		end tell
		set myPage to page 1 of myDocument
		tell myPage
			set myTextFrame2 to text frame 3 of myPage
			--Set auto sizing demension of the text frame
			tell text frame preferences of myTextFrame2
				set auto sizing type to height and width proportionally
			end tell
			--Now add text at the end of the text frame.
			set myString to return & "this is some overset text"
			tell insertion point -1 of myTextFrame2 to set contents to myString
		end tell
		set myPage to page 1 of myDocument
		tell myPage
			set myTextFrame3 to text frame 2 of myPage
			--Set  auto sizing demension of the text frame 
			--useMinimumHeightForAutoSizing and useNoLineBreaksForAutoSizing
			tell text frame preferences of myTextFrame3
				set auto sizing type to height only
				set use minimum height for auto sizing to true
				set use no line breaks for auto sizing to true
			end tell
			--Now add text at the end of the text frame.
			set myString to return & "this is some overset text"
			tell insertion point -1 of myTextFrame3 to set contents to myString
		end tell
		set myPage to page 1 of myDocument
		tell myPage
			set myTextFrame4 to text frame 1 of myPage
			--Set  auto size demension of the text frame and auto sizing reference point
			tell text frame preferences of myTextFrame4
				set auto sizing type to width only
				set auto sizing reference point to top left position
			end tell
			--Now add text at the end of the text frame.
			set myString to return & "this is some overset text"
			tell insertion point -1 of myTextFrame4 to set contents to myString
		end tell
		--![Persisted text frame fill.]
	end tell
end mySnippet
--</snippet>
--<teardown>
on myTeardown()
end myTeardown
--</teardown>