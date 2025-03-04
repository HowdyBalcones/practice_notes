--CloseWithParameter.applescript
--An InDesign Server AppleScript
tell application "InDesignServer"
	if (count documents) is greater than 0 then
		if saved of document 1 is not equal to true then
			--If the document has not been saved, save it to a file (fill in a valid file path on your system).
			tell application "Finder"
				set myFile to (startup disk as string) & "ServerTestFiles:myTestDocument.indd"
			end tell
			close document 1 saving in myFile
		else
			--If the file has already been saved, save it.
			close document 1 saving yes
		end if
	else
		set result to "There are no documents open."
	end if
end tell
