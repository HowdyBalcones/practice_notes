--FindChangeFormatting.applescripttell application "Adobe InCopy 2024"tell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Shows how to find and change text formatting.
--
my main()
on main()
	my mySetup()
	my mySnippet()
end main
on mySetup()
	tell application "Adobe InCopy 2024"
		--Create an example document.
		set myDocument to make document
		set myStory to story 1 of myDocument
		set myString to "This is some copy." & return
		set myString to myString & "This is some more copy." & return
		set myString to myString & "This is even more example copy." & return
		set myString to myString & "This is copy in another paragraph." & return
		set contents of myStory to myString
		--Apply formatting to the text.
		tell myStory
			set point size of paragraph 1 to 24
			set point size of paragraph 2 to 12
			set point size of paragraph 3 to 24
			set point size of paragraph 4 to 12
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InCopy 2024"
		--Clear the find/change preferences.
		set find text preferences to nothing
		set change text preferences to nothing
		--Search the document for the string "Text".
		set find what of find text preferences to "text"
		--Set the find options.
		set case sensitive of find change text options to false
		set include footnotes of find change text options to false
		set include hidden layers of find change text options to false
		set include locked layers for find of find change text options to false
		set include locked stories for find of find change text options to false
		set include master pages of find change text options to false
		set whole word of find change text options to false
		--Search the document for the 24 point text and change it to 10 point text.
		set point size of find text preferences to 24
		set point size of change text preferences to 10
		tell document 1
			change text
		end tell
		--Clear the find/change preferences after the search.
		set find text preferences to nothing
		set change text preferences to nothing
	end tell
end mySnippet

