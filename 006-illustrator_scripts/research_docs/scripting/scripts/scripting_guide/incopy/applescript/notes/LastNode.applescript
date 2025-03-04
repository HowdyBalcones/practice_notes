--An InCopy AppleScript
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main

on mySetup()
	tell application "Adobe InCopy 2024"
		set myDocument to make document
		
		tell story 1 of myDocument
			set contents to "This is the first paragraph of example text."
			tell insertion point -1
				--Add text to the note
				set myNote to make note
				set contents of text 1 of myNote to "This is a note."
				set myNote2 to make note
				set contents of text 1 of myNote2 to "This is a note."
			end tell
			
		end tell
	end tell
end mySetup

on mySnippet()
	tell application "Adobe InCopy 2024"
		set myStory to story 1 of active document
		set myNotes to notes of myStory
		set LastNote to last item of myNotes
		--Add text to the last note
		set contents of text 1 of LastNote to "This is the last note."
	end tell
		
end mySnippet


on myTeardown()
end myTeardown
