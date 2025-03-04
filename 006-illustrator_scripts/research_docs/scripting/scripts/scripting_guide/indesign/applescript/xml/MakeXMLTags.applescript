--MakeXMLTags.applescript
--An InDesign AppleScript
--
--Shows how to create XML tags.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
	end tell
end mySetup
on mySnippet()
	--![Make XML tags.]
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--Given a document "myDocument"...
		tell myDocument
			--You can create an XML tag without specifying a color for the tag.
			set myXMLTagA to make XML tag with properties {name:"XML_tag_A"}
			--You can define the highlight oclor of the XML tag.
			set myXMLTagB to make XML tag with properties {name:"XML_tag_B", color:gray}
			--...or you can proved an RGB array to set the color of the tag.
			set myXMLTagC to make XML tag with properties {name:"XML_tag_C", color:{0, 92, 128}}
		end tell
	end tell
	--![Make XML tags.]
end mySnippet
on myTeardown()
end myTeardown
