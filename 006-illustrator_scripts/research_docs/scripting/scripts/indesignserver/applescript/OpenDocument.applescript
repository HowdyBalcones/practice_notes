--OpenDocument.applescript
--An InDesign Server AppleScript
--Opens an existing document. You'll have to fill in your own file path.

tell application "Finder"
	set myFolder to (startup disk as string) & "ServerTestFiles"
    if not (exists myFolder) then
		make new folder at startup disk with properties{name:"ServerTestFiles"} 
    end if
    set myFile to (myFolder as string) & ":myTestDocument.indd"
	if not (exists myFile) then
		tell application "InDesignServer"
			set myNewDocument to make document
			set myNewDocument to save myNewDocument to myFile
			close myNewDocument
		end tell
	end if
end tell

tell application "InDesignServer"
	set myDocument to open myFile
	--Add a rectangle to the first page.
	tell page 1 of myDocument
		set myRectangle to make rectangle
		set geometric bounds of myRectangle to {"6p", "6p", "18p", "18p"}
		set stroke weight of myRectangle to 12
	end tell
end tell
