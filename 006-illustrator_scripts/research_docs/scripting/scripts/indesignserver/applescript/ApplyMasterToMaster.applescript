--ApplyMasterToMaster.applescript
--An InDesign Server AppleScript
--Applies a master page to a master page.
--Assumes that the default master spread name is "A-Master".
tell application "InDesignServer"
	set myDocument to make document
	tell myDocument
		--Create a new master spread.
		set myBMaster to make master spread with properties {name prefix:"B", base name:"Master"}
		--Apply master spread "A" to the first page of the new master spread.
		set applied master of page 1 of myBMaster to master spread "A-Master"
	end tell
	--Save the file (fill in a valid file path on your system).
	tell application "Finder"
		set myFile to (startup disk as string) & "ServerTestFiles:myTestDocument.indd"
	end tell
	set myDocument to save myDocument to myFile

	--Close the document
	close myDocument
end tell
