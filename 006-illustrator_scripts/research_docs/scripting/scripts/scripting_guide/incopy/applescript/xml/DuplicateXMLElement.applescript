--DuplicateXMLElement.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Duplicates an XML element in the XML hierarchy.
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
				set myXMLElementA to make XML element with properties {markup tag:myXMLTag}
				set contents of myXMLElementA to "This is XML element A."
				set myXMLElementB to make XML element with properties {markup tag:myXMLTag}
				set contents of myXMLElementB to "This is XML element B."
			end tell
			duplicate myXMLElementA
			--Place the root XML element so that you can see the result.
			tell story 1
				place XML using myRootElement
			end tell
		end tell
	end tell
end mySnippet
on myTeardown()
end myTeardown


