--ImportXML.applescript
--An InDesign AppleScript
--
--Imports an XML file.
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
		set myDocument to document 1
		--![Import XML.]
		--Given a document "myDocument"...
		tell myDocument
			--You'll need to fill in your own file path.
			import XML from "yukino:xml_test.xml"
		end tell
		--![Import XML.]
	end tell
end mySnippet
on myTeardown()
end myTeardown

