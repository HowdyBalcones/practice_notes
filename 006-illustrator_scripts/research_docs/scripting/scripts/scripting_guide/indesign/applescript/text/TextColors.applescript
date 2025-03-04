--TextColors.applescript
--An InDesign AppleScript
--
--Shows how to apply colors to the fill and stroke of text.
my main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		--Create an example document.
		set myDocument to make document
		tell myDocument
			--Create a color.
			try
				set myColorA to color "DGC1_664a"
			on error
				set myColorA to make color with properties {name:"DGC1_664a", model:process, color value:{90, 100, 70, 0}}
			end try
			--Create another color.
			try
				set myColorB to color "DGC1_664b"
			on error
				set myColorB to make color with properties {name:"DGC1_664b", model:process, color value:{70, 0, 30, 50}}
			end try
			set myPage to page 1
			tell myPage
				set myTextFrame to make text frame with properties {geometric bounds:my myGetBounds(myDocument, myPage), contents:"Text" & return & "Color"}
			end tell
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Text colors.]
		set myStory to story 1 of myDocument
		set myColorA to color "DGC1_664a" of myDocument
		set myColorB to color "DGC1_664b" of myDocument
		tell paragraph 1 of myStory
			set point size to 72
			set justification to center align
			--Apply a color to the fill of the text.
			set fill color to myColorA
			set stroke color to myColorB
		end tell
		tell paragraph 2 of myStory
			set stroke weight to 3
			set point size to 144
			set justification to center align
			set fill color to myColorB
			set stroke color to myColorA
			set stroke weight to 3
		end tell
		--![Text colors.]
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
