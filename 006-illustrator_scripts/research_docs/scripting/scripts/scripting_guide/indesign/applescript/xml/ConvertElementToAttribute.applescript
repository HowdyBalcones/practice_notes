--ConvertElementToAttribute.applescript
--An InDesign AppleScript
--
--Shows how to convert an XML element into an XML attribute.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		tell myDocument
			set myXMLTag to make XML tag with properties {name:"myXMLElement"}
			set myRootXMLElement to XML element 1
		end tell
		tell myRootXMLElement
			set myXMLElement to make XML element with properties {markup tag:myXMLTag, contents:"This is content in an XML element."}
		end tell
	end tell
end mySetup
on mySnippet()
	--![Convert element to attribute.]
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		set myRootXMLElement to XML element 1 of myDocument
		set myXMLElement to XML element 1 of myRootXMLElement
		--Given an XML Element "myXMLElement"...
		tell myXMLElement
			convert to attribute
		end tell
	end tell
	--![Convert element to attribute.]
end mySnippet
to myTeardown()
end myTeardown
