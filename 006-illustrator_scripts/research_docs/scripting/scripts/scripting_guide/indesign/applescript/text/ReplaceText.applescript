--ReplaceText.applescript
--An InDesign AppleScript
--
--Creates a text frame in an example document,
--enters text in the text frame, and then replaces
--the text of the second paragraph.
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
		--Create a text frame on current page
		tell active window
			set myPage to active page
		end tell
		set myString to "Paragraph 1" & return
		set myString to myString & "Paragraph 2" & return
		set myString to myString & "Paragraph 3" & return
		tell myPage
			set myTextFrame to make text frame with properties {geometric bounds:{72, 72, 288, 288}, contents:myString}
		end tell
	end tell
end mySetup
to mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to active document
		--![Replace text.]
		--Given a document "myDocument" with a text frame on page 1...
		set myTextFrame to text frame 1 of page 1 of myDocument
		--Replace the text in the second paragraph without
		--replacing the return character at the end of the paragraph
		--(character -2 is the character before the return).
		tell parent story of myTextFrame
			set myText to object reference of text from character 1 to character -2 of paragraph 2
			set contents of myText to "This text replaces the text in paragraph 2."
		end tell
	end tell
	--![Replace text.]
end mySnippet

to myTeardown()
end myTeardown
