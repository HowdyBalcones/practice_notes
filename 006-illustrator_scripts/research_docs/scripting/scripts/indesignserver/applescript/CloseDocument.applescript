--CloseDocument.applescript
--An InDesign Server AppleScript
--Closes the current document.
tell application "InDesignServer"
	if (count documents) is not equal to 0 then
		close document 1
	else
		set result to "No documents are open."
	end if
end tell
