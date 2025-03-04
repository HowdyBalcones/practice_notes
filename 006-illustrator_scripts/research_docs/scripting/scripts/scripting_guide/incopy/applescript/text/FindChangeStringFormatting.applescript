--FindChangeStringFormatting.applescripttell application "Adobe InCopy 2024"tell application "Adobe InCopy 2024"
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
		set myString to "Widget A. PartNumber: WIDGET0001" & return
		set myString to myString & "Widget B. PartNumber: WIDGET0002" & return
		set myString to myString & "Widget C. PartNumber: WIDGET0003" & return
		set myString to myString & "Widget D. PartNumber: WIDGET1234" & return
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
		set find what of find text preferences to "WIDGET^9^9^9^9"
		--The following line will only work if your default font has a font style named "Bold"
		--if not, change the text to a font style used by your default font.
		set font style of change text preferences to "Bold"
		--Search the document. In this example, we'll use the 
		--InCopy search metacharacter "^9" to find any digit.
		tell document 1
			set myFoundItems to change text
		end tell
		display dialog ("Changed " & (count myFoundItems) & " instances of the search string.")
		--Clear the find/change preferences after the search.
		set find text preferences to nothing
		set change text preferences to nothing
	end tell
end mySnippet
