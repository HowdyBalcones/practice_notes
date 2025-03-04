--ViewPreferences.applescript
--An InDesign AppleScrip
--
--Shows how to set the measurement units of a document.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		make document
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![View preferences.]
		--Given a document "myDocument"...
		tell view preferences of myDocument
			--Measurement unit choices are:
			--picas, points, inches, inches decimal, 
			--millimeters, centimeters, or ciceros
			--Set horizontal and vertical measurement units to points.
			set horizontal measurement units to points
			set vertical measurement units to points
		end tell
		--![View preferences.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
