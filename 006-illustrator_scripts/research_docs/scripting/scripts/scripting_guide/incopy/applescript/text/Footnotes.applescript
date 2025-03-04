--Footnotes.applescripttell application "Adobe InCopy 2024"tell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Shows how to add footnotes.
--
main()
on main()
	my mySetup()
	my mySnippet()
end main
on mySetup()
	tell application "Adobe InCopy 2024"
		set myDocument to make document
		tell footnote options of myDocument
			set separator text to "	"
			set marker positioning to superscript marker
		end tell
		set myStory to story 1 of myDocument
		set myTextFrame to item 1 of text containers of myStory
		set contents of myTextFrame to placeholder text
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InCopy 2024"
		set myDocument to document 1
		set myStory to story 1 of myDocument
		--Add four footnotes at random locations in the story.
		repeat with myCounter from 1 to 4
			set myWord to object reference of word (my myGetRandom(0, (count words in myStory))) of myStory
			tell insertion point -1 of myWord
				set myFootnote to make footnote
				tell insertion point -1 of myFootnote
					--Note: when you create a footnote, it contains text--the footnote marker
					--and the separator text (if any). If you try to set the text of the footnote
					--by setting the footnote contents, you will delete the marker. Instead, append
					--the footnote text, as shown below.
					set contents to "This is a footnote."
				end tell
			end tell
		end repeat
	end tell
end mySnippet
--This function gets a random number in the range myStart to myEnd.
on myGetRandom(myStart, myEnd)
	set myRange to myEnd - myStart
	return myStart + (random number from myStart to myEnd)
end myGetRandom
