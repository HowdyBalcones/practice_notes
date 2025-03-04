--GetChangeInfo.applescript
--An InDesign AppleScript
--
--Shows how to get Track change infomation.

main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		--![Get information about tracked changes.]
		set myDocument to document 1
		tell myDocument
			set myStory to story 1
			tell myStory
				set myChange to change 1
				tell myChange
					-- change type (inserted text/deleted text/moved text, r/o) : The type of tracked change. Note: Valid only when track changes is true.
					set myTypes to change type
					
					set myCharacters to characters
					
					set myDate to date
					
					
					set myInsertionPoints to insertion points
					
					
					set myLines to lines
					
					-- paragraphs A collection of paragraphs.
					set myParagraphs to paragraphs
					
					set myStoryOffset to story offset
					
					set myTextColumns to text columns
					
					set myTextStyleRanges to text style ranges
					
					
					set myTextsetiableInstances to text variable instances
					
					-- The user who made the change. Note: Valid only when track changes is true.
					set myUserName to user name
					-- Words  A collection of words
					set myWords to words
				end tell
			end tell
		end tell
		--![Get information about tracked changes.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
