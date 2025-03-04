--GuideAndGridPreferences.applescript
--An InDesign Server AppleScript
--Sets preferences for guides and grids.
tell application "InDesignServer"
	set myDocument to make document
	tell guide preferences of myDocument
		set guides in back to true
		set guides locked to false
		set guides shown to true
		--Objects "snap" to the guides (in InDesign) when
		--guidePreferences.guideSnapto is set to true.
		set guides snapto to true
	end tell
	tell grid preferences of myDocument
		set document grid shown to false
		--Objects "snap" to the document grid (in InDesign) when
		--document grid snapto is set to true.
		set document grid snapto to true
		--Objects "snap" to the baseline grid (in InDesign) when
		--guides snapto is set to true.
		set baseline grid shown to true
	end tell
	--Save the file (fill in a valid file path on your system).
	tell application "Finder"
		set myFile to (startup disk as string) & "ServerTestFiles:myTestDocument.indd"
	end tell
	set myDocument to save myDocument to myFile
	--Close the document
	close myDocument
end tell
