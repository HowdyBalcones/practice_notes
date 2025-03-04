--IterateAssignmentStoryProperty.applescript
--An InCopy AppleScript
--
--iterate assignment story properties.

main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
end mySetup
on mySnippet()
	tell application "Adobe InCopy 2024"
		--<fragment>
		set myDocument to document 1
		tell myDocument
			set myAssignement to assignment 1
			tell myAssignement
				set myAssignmentStory to assigned story 1
				tell myAssignmentStory
					set myName to name
					
					set myFilePath to file path
					set myStoryReference to story reference
				end tell
			end tell
		end tell
		--</fragment>
	end tell
end mySnippet
on myTeardown()
end myTeardown
