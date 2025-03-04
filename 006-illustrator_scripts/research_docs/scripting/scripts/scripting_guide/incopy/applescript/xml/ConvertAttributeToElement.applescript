--ConvertAttributeToElement.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Shows how to convert an XML attribute into an XML element.
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
		end tell
		tell myRootXMLElement
			set myXMLElementA to make XML element with properties {markup tag:myXMLTag, contents:"A"}
			set myXMLElementB to make XML element with properties {markup tag:myXMLTag, contents:"B"}
			set myXMLElementC to make XML element with properties {markup tag:myXMLTag, contents:"C"}
			set myXMLElementD to make XML element with properties {markup tag:myXMLTag, contents:"D"}
		end tell
		tell myXMLElementB
			set myAttribute to make XML attribute with properties {name:"example_attribute", value:"This is an XML attribute."}
		end tell
		tell myAttribute
			convert to element located element end markup tag myXMLTag
		end tell
		--Place the story so that you can see the result of the change.
		tell story 1 of myDocument
			place XML using myRootXMLElement
		end tell
	end tell
end mySnippet
on myTeardown()
end myTeardown

