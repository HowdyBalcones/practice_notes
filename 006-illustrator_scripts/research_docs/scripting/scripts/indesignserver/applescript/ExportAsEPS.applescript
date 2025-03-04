--ExportAsEPS.applescript
--An InDesign Server AppleScript.
--Exports the pages of the current document as a series of EPS files.
tell application "InDesignServer"
	if (count documents) is not equal to 0 then
		--You'll have to fill in your own file name. Files will be named 
		--"myFile_01.eps", "myFile_02.eps", and so on.
		tell application "Finder"
			set myFile to (startup disk as string) & "ServerTestFiles:myTestDocument.eps"
		end tell
		export document 1 format EPS type to myFile
	else
		set result to "No documents are open."
	end if
end tell
