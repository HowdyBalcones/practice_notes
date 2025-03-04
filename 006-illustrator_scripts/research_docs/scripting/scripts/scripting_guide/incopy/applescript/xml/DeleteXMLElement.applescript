--DeleteXMLElement.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Creates and deletes an XML element on the root XML element.
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
			set myXMLTag to make XML tag with properties {name:"myXMLTag"}
			set myRootElement to XML element 1
			tell myRootElement
				set myXMLElement to make XML element with properties {markup tag:myXMLTag}
			end tell
			set contents of myXMLElement to "This is an XML element containing text."
			tell myXMLElement to delete
			tell story 1
				place XML using XML element 1 of myDocument
			end tell
		end tell
	end tell
end mySnippet
on myTeardown()
end myTeardown
