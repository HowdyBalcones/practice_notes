--MakeAttribute.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Creates an XML attribute.
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
			set myXMLTag to make XML tag with properties {name:"myXMLElement"}
			set myRootXMLElement to XML element 1
			tell myRootXMLElement
				set myXMLElement to make XML element with properties {markup tag:myXMLTag}
				tell myXMLElement
					make XML attribute with properties {name:"example_attribute", value:"This is an XML attribute."}
				end tell
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
