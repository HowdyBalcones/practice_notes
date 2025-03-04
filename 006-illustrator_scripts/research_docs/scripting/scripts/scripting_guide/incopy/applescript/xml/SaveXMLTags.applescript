--SaveXMLTags.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Saves a set of XML tags to a file.
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
			set myXMLTagA to make XML tag with properties {name:"XMLTagA"}
			set myXMLTagB to make XML tag with properties {name:"XMLTagB"}
			set myXMLTagC to make XML tag with properties {name:"XMLTagC"}
			save XML tags to "yukino:xml_tags.xml" version comments "Tag set created October 5, 2006"
		end tell
	end tell
end mySnippet
on myTeardown()
end myTeardown
