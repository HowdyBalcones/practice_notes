--ImprovedHelloWorld.applescript
--An InCopy AppleScript
--
tell application "Adobe InCopy 2024"
	--Get a reference to a font.
	try
		--Enter the name of a font on your system, if necessary.
		set myFont to font "Arial"
	end try
	--Get the active document and assign the result to the variable "myDocument"
	set myDocument to document 1
	tell story 1 of myDocument
		--Change the font, size, and paragraph alignment.
		try
			set applied font to myFont
		end try
		set point size to 72
		set justification to center align
		--Enter the note at the last insertion point of the story.
		tell insertion point -1
			set myNote to make note
			set contents of text 1 of myNote to "This is a note."
		end tell
	end tell
end tell
