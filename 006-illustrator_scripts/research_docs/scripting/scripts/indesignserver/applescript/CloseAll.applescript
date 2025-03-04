--CloseAll.applescript
--An InDesign Server AppleScript
--Closes all open documents without saving.
tell application "InDesignServer"
	tell documents to close saving no
end tell
