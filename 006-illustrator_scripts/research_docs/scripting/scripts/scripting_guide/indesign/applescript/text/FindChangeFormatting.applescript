--FindChangeFormatting.applescript
--An InDesign AppleScript
--
--Shows how to find and change text formatting.
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
		set myString to "Widget A. PartNumber: WIDGET0001" & return
		set myString to myString & "Widget B. PartNumber: WIDGET0002" & return
		set myString to myString & "Widget C. PartNumber: WIDGET0003" & return
		set myString to myString & "Widget D. PartNumber: WIDGET1234" & return
		set myPage to page 1 of myDocument
		tell myPage
			set myTextFrame to make text frame with properties {geometric bounds:my myGetBounds(myDocument, myPage), contents:myString}
		end tell
		repeat with myCounter from 1 to count paragraphs in parent story of myTextFrame
			set point size of word -1 of paragraph myCounter of myTextFrame to 24
		end repeat
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		--![Find change formatting.]
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
		set point size of find text preferences to 24
		--The following line will only work if your default font has a font style named "Bold"
		--if not, change the text to a font style used by your default font.
		set point size of change text preferences to 48
		--Search the document. In this example, we'll use the 
		--InDesign search metacharacter "^9" to find any digit.
		tell document 1
			set myFoundItems to change text
		end tell
		display dialog ("Changed " & (count myFoundItems) & " instances of the search string.")
		--Clear the find/change preferences after the search.
		set find text preferences to nothing
		set change text preferences to nothing
		--![Find change formatting.]
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
