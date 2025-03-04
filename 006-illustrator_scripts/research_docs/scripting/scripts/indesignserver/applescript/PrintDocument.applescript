--PrintDocument.applescript
--An InDesign Server AppleScript
--Prints the active document using the current print settings.
tell application "InDesignServer"
	if (count documents) is not equal to 0 then
		--The print method has one optional parameter, Using,
		--which sets the printer preset to use. The following line
		--prints the document using the default settings
		print document 1
		--To print the document using a preset named "ColorProof":
		--print document 1 using "ColorProof"
	else
		set result to "No documents are open."
	end if
end tell
