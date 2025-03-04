--SetTextDefaultToStyle.applescript
--An InDesign Server AppleScript
--Sets the default paragraph style for text in a document.
tell application "InDesignServer"
	set myDocument to make document
	tell myDocument
		--If the paragraph style "BodyText" does not already exist, create it.
		try
			set myParagraphStyle to paragraph style "BodyText"
		on error
			set myParagraphStyle to make paragraph style with properties {name:"BodyText"}
		end try
		set applied paragraph style of text defaults to myParagraphStyle
	end tell
	--Save the file (fill in a valid file path on your system).
	tell application "Finder"
		set myFile to (startup disk as string) & "ServerTestFiles:myTestDocument.indd"
	end tell
	set myDocument to save myDocument to myFile
	--Close the document
	close myDocument
end tell
