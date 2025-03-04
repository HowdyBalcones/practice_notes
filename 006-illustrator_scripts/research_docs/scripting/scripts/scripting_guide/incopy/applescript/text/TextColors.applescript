--TextColors.applescripttell application "Adobe InCopy 2024"tell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Shows how to apply colors to the fill and stroke of text.
my main()
on main()
	my mySetup()
	my mySnippet()
end main
on mySetup()
	tell application "Adobe InCopy 2024"
		--Create an example document.
		set myDocument to make document
		--Create a color.
		try
			set myColorA to color "DGC1_664a" of myDocument
		on error
			set myColorA to make color with properties {name:"DGC1_664a", model:process, color value:{90, 100, 70, 0}}
		end try
		--Create another color.
		try
			set myColorB to color "DGC1_664b" of myDocument
		on error
			set myColorB to make color with properties {name:"DGC1_664b", model:process, color value:{70, 0, 30, 50}}
		end try
		set myStory to story 1 of myDocument
		--Enter text in the text frame.
		set contents of myStory to "Text
 Color"
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InCopy 2024"
		set myDocument to document 1
		set myStory to story 1 of myDocument
		set myColorA to color "DGC1_664a" of myDocument
		set myColorB to color "DGC1_664b" of myDocument
		tell paragraph 1 of myStory
			set stroke weight to 3
			set point size to 72
			set justification to center align
			--Apply a color to the fill of the text.
			set fill color to myColorA
			set stroke color to myColorB
		end tell
	end tell
end mySnippet
