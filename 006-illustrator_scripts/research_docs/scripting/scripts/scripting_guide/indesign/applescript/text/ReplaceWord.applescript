--ReplaceWord.applescript
--An InDesign AppleScript
--
--Creates a text frame in an example document,
--enters text in the text frame, and then replaces
--a word in the frame with a different phrase.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		--Set the measurement units to points
		tell view preferences of myDocument
			set horizontal measurement units to points
			set vertical measurement units to points
			--Set the ruler origin to page origin.
			set ruler origin to page origin
		end tell
		set myPage to page 1 of document 1
		tell myPage
			set myTextFrame to make text frame with properties {geometric bounds:{72, 72, 96, 288}, contents:"This is some example text."}
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Replace word.]
		--Given a document "myDocument" with a text frame on page 1...
		set myTextFrame to text frame 1 of page 1 of myDocument
		--Replace the third word with the phrase "a little bit of".
		tell word 3 of parent story of myTextFrame
			set contents to "a little bit of"
		end tell
		--![Replace word.]
	end tell
end mySnippet
to myTeardown()
end myTeardown
