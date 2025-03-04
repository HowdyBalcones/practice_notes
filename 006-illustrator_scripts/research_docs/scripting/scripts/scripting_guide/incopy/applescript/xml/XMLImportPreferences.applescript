--XMLImportPreferences.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Sets XML import options.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
end mySetup
on mySnippet()
	tell application "Adobe InCopy 2024"
		set myDocument to make document
		tell myDocument
			tell XML import preferences
				set allow transform to false
				set create link to XML to false
				set ignore unmatched incoming to true
				set ignore whitespace to true
				set import CALS tables to true
				set import style to merge import
				set import text into tables to false
				set import to selected to false
				set remove unmatched existing to false
				set repeat text elements to true
				--The following properties are only used when the 
				--allow transform property is set to true.
				--set transform filename to "yukino:myTransform.xsl"
				--If you have defined parameters in your XSL file,
				--you can pass them to the file during the XML import
				--process. For each parameter, enter a list containign two
				--strings. The first string is the name of the parameter,
				--the second is the value of the parameter.
				--set transform parameters to {{"format", "1"}}
			end tell
		end tell
	end tell
end mySnippet
on myTeardown()
end myTeardown
