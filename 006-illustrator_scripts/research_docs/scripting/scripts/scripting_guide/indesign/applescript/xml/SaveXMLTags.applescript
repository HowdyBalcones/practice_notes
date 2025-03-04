--SaveXMLTags.applescript
--An InDesign AppleScript
--
--Saves a set of XML tags to a file.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		tell myDocument
			set myXMLTagA to make XML tag with properties {name:"XMLTagA"}
			set myXMLTagB to make XML tag with properties {name:"XMLTagB"}
			set myXMLTagC to make XML tag with properties {name:"XMLTagC"}
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to active document
		--![Save XML tags.]
		tell myDocument
			--You'll have to fill in your own file path.
			save XML tags to "yukino:xml_tags.xml" version comments "Tag set created May 23, 2008"
		end tell
		--![Save XML tags.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
