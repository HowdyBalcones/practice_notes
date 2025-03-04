--HelloWorld.applescript
--An InCopy AppleScript
--
--Creates an example document.
tell application "Adobe InCopy 2024"
	set myDocument to make document
	set myStory to story 1 of myDocument
	tell myStory
		set contents to "Hello World!"
	end tell
end tell
