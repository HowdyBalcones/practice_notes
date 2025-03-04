--Footnotes.applescript
--An InDesign AppleScript
--
--Shows how to add footnotes.
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
		--Create a text frame on page 1.
		set myPage to page 1 of myDocument
		tell myPage
			set myTextFrame to make text frame with properties {geometric bounds:my myGetBounds(myDocument, myPage), contents:placeholder text}
		end tell
		tell myDocument
			set myNewPage to make page
			tell myNewPage
				set myNewTextFrame to make text frame with properties {geometric bounds:my myGetBounds(myDocument, myNewPage)}
			end tell
		end tell
		set next text frame of myTextFrame to myNewTextFrame
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		--![Footnotes.]
		set myDocument to document 1
		tell footnote options of myDocument
			set separator text to tab
			set marker positioning to superscript marker
		end tell
		set myStory to story 1 of myDocument
		--Add four footnotes at random locations in the story.
		local myStoryLength, myRandomNumber
		set myStoryLength to (count words of myStory)
		repeat with myCounter from 1 to 5
			set myRandomNumber to my myGetRandom(1, myStoryLength)
			tell insertion point -1 of word myRandomNumber of myStory
				set myFootnote to make footnote
			end tell
			--Note: when you create a footnote, it contains text--the footnote marker
			--and the separator text (if any). If you try to set the text of the footnote
			--by setting the footnote contents, you will delete the marker. Instead, append
			--the footnote text, as shown below.
			tell insertion point -1 of myFootnote
				set contents to "This is a footnote."
			end tell
		end repeat
		--![Footnotes.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
--This function gets a random integer in the range myStart to myEnd.
on myGetRandom(myStart, myEnd)
	set myRange to myEnd - myStart
	set myRandomInteger to (myStart + (random number from myStart to myEnd)) as integer
	return myRandomInteger
end myGetRandom
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
