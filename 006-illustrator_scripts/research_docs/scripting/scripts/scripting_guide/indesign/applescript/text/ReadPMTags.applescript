--ReadPMTags.applescript
--An InDesign AppleScript
--
--Shows how to use regular expressions to read an imported PageMaker paragraph tags file.
--PageMaker paragraph tags (which are not the same as PageMaker tagged text format files) are a
--simplified text markup scheme. Paragraph style names appear at the start of a paragraph:
--
--<heading1>This is some text.
--<body_text>This is body text.
my main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		--Create some example marked-up text (as if it had been imported).
		set myString to "<heading1>Heading One." & return
		set myString to myString & "<body_text>This is an example paragraph of body text." & return
		set myString to myString & "<body_text>This is another example paragraph of body text." & return
		set myString to myString & "<heading2>Heading Two." & return
		set myString to myString & "<body_text>This is an example paragraph of body text." & return
		set myString to myString & "<body_text>This is another example paragraph of body text." & return
		set myString to myString & "<heading2>Heading Two." & return
		set myString to myString & "<body_text>This is an example paragraph of body text." & return
		set myString to myString & "<body_text>This is another example paragraph of body text." & return
		--Create an example document.
		set myDocument to make document
		set myPage to page 1 of myDocument
		tell myPage
			set myTextFrame to make text frame with properties {geometric bounds:my myGetBounds(myDocument, myPage), contents:myString}
		end tell
	end tell
end mySetup

on mySnippet()
	tell application "Adobe InDesign 2024"
		--![Read PMTags.]
		set myStory to story 1 of document 1
		my myReadPMTags(myStory)
		--![Read PMTags.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
--![Read PMTags - functions.]
on myReadPMTags(myStory)
	local myFoundTags, myFoundItems, myFoundTag, myString, myStyleName, myStyle
	tell application "Adobe InDesign 2024"
		set myDocument to parent of myStory
		--Reset the find grep preferences to ensure that 
		--previous settings do not affect the search.
		set find grep preferences to nothing
		set change grep preferences to nothing
		--Set the find options.
		set include footnotes of find change grep options to false
		set include hidden layers of find change grep options to false
		set include locked layers for find of find change grep options to false
		set include locked stories for find of find change grep options to false
		set include master pages of find change grep options to false
		--Find the tags.
		set find what of find grep preferences to "(?i)^<\\s*\\w+\\s*>"
		tell myStory
			set myFoundItems to find grep
		end tell
		if (count myFoundItems) is not equal to 0 then
			set myFoundTags to {}
			repeat with myCounter from 1 to (count myFoundItems)
				set myFoundTag to contents of item myCounter of myFoundItems
				if myFoundTags does not contain myFoundTag then
					copy myFoundTag to end of myFoundTags
				end if
			end repeat
			--At this point, we have a list of tags to search for.
			repeat with myCounter from 1 to (count myFoundTags)
				set myString to item myCounter of myFoundTags
				--Find the tag using find what.
				set find what of find text preferences to myString
				--Extract the style name from the tag.
				set myStyleName to text 2 through ((count characters of myString) - 1) of myString
				tell myDocument
					--Create the style if it does not already exist.
					try
						set myStyle to paragraph style myStyleName
					on error
						set myStyle to make paragraph style with properties {name:myStyleName}
					end try
				end tell
				--Apply the style to each instance of the tag.
				set applied paragraph style of change text preferences to myStyle
				tell myStory
					change text
				end tell
				--Reset the change text preferences.
				set change text preferences to nothing
				--Set the change to property to an empty string.
				set change to of change text preferences to ""
				--Search to remove the tags.
				tell myStory
					change text
				end tell
				--Reset the find/change preferences again.
				set change text preferences to nothing
			end repeat
		end if
		--Reset the findGrepPreferences.
		set find grep preferences to nothing
	end tell
end myReadPMTags
--![Read PMTags - functions.]
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
