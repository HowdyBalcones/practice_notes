--MakeProcessingInstruction.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Creates an XML processing instruction on the root XML element.
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
			set myRootXMLElement to XML element 1
			tell myRootXMLElement
				set myXMLInstruction to make XML instruction with properties {target:"xml-stylesheet type=\"text/css\"", data:"href=\"generic.css\""}
			end tell
			--Place the XML root element so that you can see the result in the Structure panel.
			tell story 1
				place XML using myRootXMLElement
			end tell
		end tell
	end tell
end mySnippet
on myTeardown()
end myTeardown
