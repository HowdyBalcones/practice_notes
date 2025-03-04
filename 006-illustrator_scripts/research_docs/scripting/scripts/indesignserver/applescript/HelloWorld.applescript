--HelloWorld.applescript
tell application "InDesignServer"
	--Create a new document.
	set myDocument to make document
	--Get a reference to the first page.
	tell myDocument
		--Create a new text frame on the first page.
		tell page 1
			set myTextFrame to make text frame
			--Change the size of the text frame.
			set geometric bounds of myTextFrame to {"6p", "6p", "18p", "18p"}
			--Enter text in the text frame.
			set contents of myTextFrame to "Hello World!"
		end tell
		--Save the file (fill in a valid file path).
		tell application "Finder"
			set myFile to (startup disk as string) & "ServerTestFiles:HelloWorld.indd"
		end tell
		save to myFile
	end tell
	--Close the document.
	close document 1
end tell
