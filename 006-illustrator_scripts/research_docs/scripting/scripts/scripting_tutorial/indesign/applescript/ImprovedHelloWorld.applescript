--Improved "Hello World"
tell application "Adobe InDesign 2024"
	--Get a reference to a font.
	try
		--Enter the name of a font on your system, if necessary.
		set myFont to font "Helvetica"
	end try
	--Get the active document and assign the result to the variable "myDocument."
	set myDocument to document 1
	tell myDocument
		--Use the handler "myGetBounds" to get the bounds of the
		--"live area" inside the margins of page 1.
		set myBounds to my myGetBounds(myDocument, page 1)
		tell text frame 1 of page 1
			--Resize the text frame to match the page margins.
			set geometric bounds to myBounds
			tell paragraph 1
				--Change the font, size, and paragraph alignment.
				try
					set applied font to myFont
				end try
				set point size to 72
				set justification to center align
			end tell
		end tell
	end tell
end tell
--myGetBounds is a handler that returns the bounds of the "live area" of a page.
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
