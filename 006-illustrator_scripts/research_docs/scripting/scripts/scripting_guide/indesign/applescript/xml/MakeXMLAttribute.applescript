--MakeXMLAttribute.applescript
--An InDesign AppleScript
--
--Creates an XML attribute.
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
			tell myRootXMLElement
				set myXMLElement to make XML element with properties {markup tag:myXMLTag}
			end tell
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Make XML attribute.]
		tell myDocument
			set myRootXMLElement to XML element 1
			set myXMLElement to XML element 1 of myRootXMLElement
			tell myXMLElement
				make XML attribute with properties {name:"example_attribute", value:"This is an XML attribute."}
			end tell
		end tell
		--![Make XML attribute.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
