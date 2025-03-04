--ReadPMTags.applescripttell application "Adobe InCopy 2024"tell application "Adobe InCopy 2024"tell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Shows how to use regular expressions to read an imported PageMaker paragraph tags file.
--PageMaker paragraph tags (which are not the same as PageMaker tagged text format files) are a
--simplified text markup scheme. Paragraph style names appear at the start of a paragraph:
--
--<heading1>This is some text.
--<body_text>This is body text.
--
my main()
on main()
	my mySetup()
	my mySnippet()
end main
on mySetup()
	tell application "Adobe InCopy 2024"
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
		set myStory to story 1 of myDocument
		set contents of myStory to myString
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InCopy 2024"
		set myStory to story 1 of document 1
		my myReadPMTags(myStory)
	end tell
end mySnippet
on myReadPMTags(myStory)
	local myFoundTags, myFoundItems, myFoundTag, myString, myStyleName, myStyle
	tell application "Adobe InCopy 2024"
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

