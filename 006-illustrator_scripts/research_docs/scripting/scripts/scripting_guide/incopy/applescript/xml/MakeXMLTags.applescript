--MakeXMLTags.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Creates a series of XML tags.
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
			--You can create an XML tag without specifying a color for the tag.
			set myXMLTagA to make XML tag with properties {name:"XML_tag_A"}
			--You can define the highlight oclor o fthe XML tag.
			set myXMLTagB to make XML tag with properties {name:"XML_tag_B", color:gray}
			--...or you can proved an RGB array to set the color of the tag.
			set myXMLTagC to make XML tag with properties {name:"XML_tag_C", color:{0, 92, 128}}
		end tell
	end tell
end mySnippet
on myTeardown()
end myTeardown
