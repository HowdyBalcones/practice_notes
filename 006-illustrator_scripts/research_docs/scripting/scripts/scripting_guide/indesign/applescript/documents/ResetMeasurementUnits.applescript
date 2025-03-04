--ResetMeasurementUnits.applescript
--An InDesign AppleScript
--
--Shows how to change, then reset a document's measurement units.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Reset measurement units.]
		--Given a document "myDocument"...
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
		--![Reset measurement units.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
