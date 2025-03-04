--ImportXMLElement.applescript
--An InCopy AppleScript
--
--Imports an XML file.
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
			set myRootElement to XML element 1
			tell myRootElement
				import XML from "Macintosh HD:c:test.xml"
			end tell
			--Place the root XML element so that you can see the result.
			tell story 1
				place XML using myRootElement
			end tell
		end tell
	end tell
end mySnippet
on myTeardown()
end myTeardown

