--LoadXMLTags.applescript
--An InCopy AppleScript
--
--Loads a set of XML tags from a file.
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
			--You'll have to enter a valid file path for your system.
			load XML tags from "Macintosh HD:c:xml_tags.xml"
		end tell
	end tell
end mySnippet
on myTeardown()
end myTeardown
