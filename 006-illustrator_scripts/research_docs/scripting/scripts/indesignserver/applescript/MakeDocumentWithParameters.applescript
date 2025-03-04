--MakeDocumentWithParameters.applescript
--An InDesign Server AppleScript
--Creates a new document.
--The parameter document preset specifies the document preset to use.
--The following line assumes that you have defined a document preset named
--"7x9Book" (the example script DocumentPreset.applescript will create a preset
--with this name).
tell application "InDesignServer"
	set myDocument to make document with properties {document preset:"7x9Book"}
	--Save the file (fill in a valid file path for your system).
	tell application "Finder"
		set myFile to (startup disk as string) & "ServerTestFiles:myTestDocument.indd"
	end tell
	set myDocument to save myDocument to myFile
	--Close the document.
	close myDocument
end tell
