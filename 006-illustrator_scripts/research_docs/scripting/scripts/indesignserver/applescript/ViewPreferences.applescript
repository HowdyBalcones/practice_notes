--ViewPreferences.applescript
--An InDesign Server AppleScript
--Changes the measurement units used by the current document.
--Assumes you have a document open.
tell application "InDesignServer"
	if (count documents) is greater than 0 then
		set myDocument to document 1
		tell view preferences of myDocument
			--Measurement unit choices are:
			--* picas
			--* points
			--* inches
			--* inches decimal
			--* millimeters
			--* centimeters
			--* ciceros
			--* custom
			--InDesign J additional measurement units:
			--* american points
			--* ha
			--* q
			--If you set the the vertical or horizontal measurement units
			--to custom, you can also set a custom ruler increment (in points) using:
			--set horizontal custom points to 15
			--set vertical custom points to 15
			--Set horizontal and vertical measurement units to points.
			set horizontal measurement units to points
			set vertical measurement units to points
		end tell
		--Save the file (fill in a valid file path on your system).
		tell application "Finder"
			set myFile to (startup disk as string) & "ServerTestFiles:myTestDocument.indd"
		end tell
		set myDocument to save myDocument to myFile
		--Close the document
		close myDocument
	else
		set result to "No documents are open."
	end if
end tell
