--DeleteXMLElement.applescript
--An InDesign AppleScript
--
--Creates and deletes an XML element on the root XML element.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		set myXMLTag to make XML tag with properties {name:"myXMLTag"}
		set myRootElement to XML element 1
		tell myRootElement
			set myXMLElement to make XML element with properties {markup tag:myXMLTag}
		end tell
		set contents of myXMLElement to "This is an XML element containing text."
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		tell myDocument
			--![Delete XML element.]
			set myRootElement to XML element 1
			set myXMLElement to XML element 1 of myRootElement
			--Given an XML element "myXMLElement"...
			tell myXMLElement to delete
			--![Delete XML element.]
		end tell
	end tell
end mySnippet
on myTeardown()
end myTeardown
