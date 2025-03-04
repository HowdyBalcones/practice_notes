--ChangeText.applescripttell application "Adobe InCopy 2024"tell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Shows how to find and change text.
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
		set myString to "This is some copy. This is some more copy. This is even more example copy." & return
		set myString to myString & "This is copy in another paragraph." & return
		set contents of myStory to myString
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InCopy 2024"
		--Clear the find/change preferences.
		set find text preferences to nothing
		set change text preferences to nothing
		--Set the find options.
		set case sensitive of find change text options to false
		set include footnotes of find change text options to false
		set include hidden layers of find change text options to false
		set include locked layers for find of find change text options to false
		set include locked stories for find of find change text options to false
		set include master pages of find change text options to false
		set whole word of find change text options to false
		--Search the document for the string "copy" and change it to "text".
		--Search the document for the string "copy".
		set find what of find text preferences to "copy"
		set change to of change text preferences to "text"
		tell document 1
			set myFoundItems to change text
		end tell
		display dialog ("Changed " & (count myFoundItems) & " instances of the search string.")
		--Clear the find/change preferences after the search.
		set find text preferences to nothing
		set change text preferences to nothing
	end tell
end mySnippet

