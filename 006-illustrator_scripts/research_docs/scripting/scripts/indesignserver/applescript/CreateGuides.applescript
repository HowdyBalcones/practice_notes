--CreateGuides.applescript
--An InDesign Server AppleScript
--
--Adds a series of guides using the createGuides method.
tell application "InDesignServer"
	set myDocument to make document
	tell spread 1 of myDocument
		--Parameters (all optional): row count, column count, row gutter, 
		--column gutter,guide color, fit margins, remove existing, layer.
		--Note that the createGuides method does not take an RGB array 
		--for the guide color parameter.
		create guides number of rows 4 number of columns 4 row gutter "1p" column gutter "1p" guide color gray with fit margins and remove existing
	end tell
end tell
