--FindText.applescript
--An InDesign AppleScript
--
--Shows how to find text.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		--Create an example document.
		set myDocument to make document
		set myString to "This is some text. This is some more text."
		set myString to myString & "This is even more example text." & return
		set myString to myString & "This is text in another paragraph."
		set myPage to active page of active window
		tell myPage
			set myTextFrame to make text frame with properties {geometric bounds:my myGetBounds(myDocument, myPage), contents:myString}
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		--![Find text.]
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
		tell active document
			set myFoundItems to find text
			display dialog ("Found " & (count myFoundItems) & " instances of the search string.")
		end tell
		--![Find text.]
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
