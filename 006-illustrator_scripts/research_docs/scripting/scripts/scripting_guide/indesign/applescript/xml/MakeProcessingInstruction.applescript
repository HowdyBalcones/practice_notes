--MakeProcessingInstruction.applescript
--An InDesign AppleScript
--
--Adds an XML processing instruction to the root XML element.
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
		--![Make processing instruction.]
		--Given a document "myDocument"...
		tell myDocument
			set myRootXMLElement to XML element 1
			tell myRootXMLElement
				set myXMLInstruction to make XML instruction with properties {target:"xml-stylesheet type=\"text/css\"", data:"href=\"generic.css\""}
			end tell
		end tell
		--![Make processing instruction.]
	end tell
end mySnippet
on myTeardown()
end myTeardown

