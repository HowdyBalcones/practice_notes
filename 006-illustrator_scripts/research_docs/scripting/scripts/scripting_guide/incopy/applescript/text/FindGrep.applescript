--FindGrep.applescripttell application "Adobe InCopy 2024"tell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Shows how to use regular expressions (i.e., "grep") to find and change text.
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
		set myString to "This is an email address: okvern@adobe.com or anyone@adobe.com.
This is some more copy with an email address that is not 24-points: okvern@adobe.com or anyone@adobe.com
This is even more example copy in 24 point text. With an email address: okvern@adobe.com.
This is copy in another paragraph."
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
		set find grep preferences to nothing
		set change grep preferences to nothing
		--Set the find options.
		set include footnotes of find change grep options to false
		set include hidden layers of find change grep options to false
		set include locked layers for find of find change grep options to false
		set include locked stories for find of find change grep options to false
		set include master pages of find change grep options to false
		--Regular expression for finding an email address.
		set find what of find grep preferences to "(?i)[A-Z0-9]*?@[A-Z0-9]*?[.]..."
		--Apply the change to 24-point text only.
		set point size of find grep preferences to 24
		set underline of change grep preferences to true
		tell document 1
			change grep
		end tell
		--Clear the find/change preferences after the search.
		set find grep preferences to nothing
		set change grep preferences to nothing
	end tell
end mySnippet
