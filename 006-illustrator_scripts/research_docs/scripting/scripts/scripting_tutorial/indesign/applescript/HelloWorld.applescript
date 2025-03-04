--HelloWorld.applescript
--An InDesign AppleScript
--
tell application "Adobe InDesign 2024"
	set myDocument to make document
	tell page 1 of myDocument
		set myTextFrame to make text frame
		set geometric bounds of myTextFrame to {"6p", "6p", "24p", "24p"}
		set contents of myTextFrame to "Hello World!"
	end tell
end tell