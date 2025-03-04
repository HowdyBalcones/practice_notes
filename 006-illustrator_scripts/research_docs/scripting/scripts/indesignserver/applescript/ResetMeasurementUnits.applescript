--ResetMeasurementUnits.applescript
--An InDesign Server AppleScript
--Sets measurement units, performs some actions, and then 
--resets measurement units to their original values.
--Assumes you have a document open.
tell application "InDesignServer"
	set myDocument to document 1
	tell view preferences of myDocument
		set myOldXUnits to horizontal measurement units
		set myOldYUnits to vertical measurement units
		set horizontal measurement units to points
		set vertical measurement units to points
	end tell
	--At this point, you can perform any series of script actions that depend on
	--the measurement units you've set. At the end of the script, reset
	--the measurement units to their original state.
	tell view preferences of myDocument
		set horizontal measurement units to myOldXUnits
		set vertical measurement units to myOldYUnits
	end tell
end tell
