--RemoveStyle.applescript
--An InCopy AppleScript
--
--Shows how to remove a paragraph style.
--
my main()
on main()
	my mySetup()
	my mySnippet()
end main
on mySetup()
	local myParagraph
	tell application "Adobe InCopy 2024"
		--Create an example document.
		set myDocument to make document
		tell myDocument
			--Create a color for use by one of the paragraph styles we'll create.
			try
				set myColor to color "Red"
			on error
				--The color did not exist, so create it.
				set myColor to make color with properties {name:"Red", model:process, color value:{0, 100, 100, 0}}
			end try
			--Create a paragraph style named "myParagraphStyleA" if no 
			--style by that name already exists.
			try
				set myParagraphStyleA to paragraph style "myParagraphStyleA"
			on error
				--The paragraph style did not exist, so create it.
				set myParagraphStyleA to make paragraph style with properties {name:"myParagraphStyleA"}
			end try
			--Create another paragraph style.
			try
				set myParagraphStyleB to paragraph style "myParagraphStyleB"
			on error
				--The paragraph style did not exist, so create it.
				set myParagraphStyleB to make paragraph style with properties {name:"myParagraphStyleB"}
			end try
			set fill color of myParagraphStyleB to myColor
			tell story 1
				set myTextFrame to item 1 of text containers
				set contents of myTextFrame to placeholder text
				--Apply myParagraphStyleA to random paragraphs in the story (using the anyItem method).
				repeat with myCounter from 1 to 5
					set myParagraph to object reference of some paragraph
					tell myParagraph
						apply paragraph style using myParagraphStyleA clearing overrides yes
					end tell
				end repeat
			end tell
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InCopy 2024"
		local myParagraphStyleA, myParagraphStyleB
		set myDocument to document 1
		tell myDocument
			set myParagraphStyleA to paragraph style "myParagraphStyleA"
			set myParagraphStyleB to paragraph style "myParagraphStyleB"
			--Remove the paragraph style myParagraphStyleA and replace with myParagraphStyleB.
			delete myParagraphStyleA replacing with myParagraphStyleB
		end tell
	end tell
end mySnippet
