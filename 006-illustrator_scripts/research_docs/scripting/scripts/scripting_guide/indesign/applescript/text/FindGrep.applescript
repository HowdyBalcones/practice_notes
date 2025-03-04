--FindGrep.applescript
--An InDesign AppleScript
--
--Shows how to use regular expressions (i.e., "grep") to find and change text.
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
		set p1 to "This is an email address: someone@adobe.com or anyone@adobe.com." & return
		set p2 to "This is some more copy with an email address that "
		set p3 to "is not 24-points: someone@adobe.com or anyone@adobe.com" & return
		set p4 to "This is even more example copy in 24 point text. "
		set p5 to "With an email address: someone@adobe.com." & return
		set p6 to "This is copy in another paragraph." & return
		set p7 to "Note that all 24 pt email addresses are underlined." & return
		set myString to p1 & p2 & p3 & p4 & p5 & p6 & p7
		set myPage to page 1 of myDocument
		tell myPage
			set myTextFrame to make text frame with properties {geometric bounds:my myGetBounds(myDocument, myPage), contents:myString}
		end tell
		--Apply formatting to the text.
		tell parent story of myTextFrame
			set point size of paragraph 1 to 24
			set point size of paragraph 2 to 12
			set point size of paragraph 3 to 24
			set point size of paragraph 4 to 12
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Find grep.]
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
		tell myDocument
			change grep
		end tell
		--Clear the find/change preferences after the search.
		set find grep preferences to nothing
		set change grep preferences to nothing
		--![Find grep.]
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
