--FindText.applescripttell application "Adobe InCopy 2024"tell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Shows how to find text.
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
		set myString to "This is some text. This is some more text. This is even more example text." & return
		set myString to myString & "This is text in another paragraph." & return
		set contents of myStory to myString
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
		tell document 1
			set myFoundItems to find text
			display dialog ("Found " & (count myFoundItems) & " instances of the search string.")
		end tell
	end tell
end mySnippet
