--LoadXMLTags.applescript
--An InDesign AppleScript
--
--Loads a set of XML tags from a file.
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
	tell application "Adobe InDesign 2024"
		set myDocument to active document
		--![Load XML tags.]
		--Given a document "myDocument"...
		tell myDocument
			--You'll have to enter a valid file path for your system.
			load XML tags from "yukino:xml_tags.xml"
		end tell
		--![Load XML tags.]
	end tell
end mySnippet
on myTeardown()
end myTeardown

