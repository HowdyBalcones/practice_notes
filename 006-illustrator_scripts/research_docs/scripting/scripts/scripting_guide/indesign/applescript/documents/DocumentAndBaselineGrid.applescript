--DocumentAndBaselineGrid.applescript
--An InDesign AppleScript
--
--Sets up the document grid and baseline grid preferences in a new document.
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
		--![Setting grid preferences.]
		--Given a document "myDocument"...
		set myPage to page 1 of myDocument
		set horizontal measurement units of view preferences of myDocument to points
		set vertical measurement units of view preferences of myDocument to points
		tell grid preferences of myDocument
			set baseline start to 56
			set baseline division to 14
			set baseline grid shown to true
			set horizontal gridline division to 14
			set horizontal grid subdivision to 5
			set vertical gridline division to 14
			set vertical grid subdivision to 5
			set document grid shown to true
		end tell
		--![Setting grid preferences.]
	end tell
end mySnippet
on myTeardown()
end myTeardown

