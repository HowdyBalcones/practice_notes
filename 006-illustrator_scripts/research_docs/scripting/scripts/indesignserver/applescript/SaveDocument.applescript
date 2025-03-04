--SaveDocument.applescript
--An InDesign Server AppleScript
--Saves the active document.
--If the current document has been changed since it was last saved, save it.
tell application "InDesignServer"
	if (count documents) is greater than 0 then
		if modified of document 1 is true and saved of document 1 is true then
			tell document 1 to save
		end if
	else
		set result to "No documents are open."
	end if
end tell
