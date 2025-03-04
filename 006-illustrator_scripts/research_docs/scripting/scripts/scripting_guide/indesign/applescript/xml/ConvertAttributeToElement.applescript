--ConvertAttributeToElement.applescript
--An InDesign AppleScript
--
--Shows how to convert an XML attribute into an XML element.
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
		end tell
		set myRootXMLElement to XML element 1 of myDocument
		tell myRootXMLElement
			set myXMLElementA to make XML element with properties {markup tag:myXMLTag, contents:"A"}
			set myXMLElementB to make XML element with properties {markup tag:myXMLTag, contents:"B"}
			set myXMLElementC to make XML element with properties {markup tag:myXMLTag, contents:"C"}
			set myXMLElementD to make XML element with properties {markup tag:myXMLTag, contents:"D"}
		end tell
		tell myXMLElementB
			set myAttribute to make XML attribute with properties {name:"example_attribute", value:"This is an XML attribute."}
		end tell
		set myPage to page 1 of myDocument
		tell myPage
			set myTextFrame to make text frame with properties {geometric bounds:my myGetBounds(myDocument, myPage)}
		end tell
	end tell
end mySetup
on mySnippet()
	--![Convert attribute to element.]
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		set myXMLTag to XML tag "myXMLElement" of myDocument
		set myRootXMLElement to XML element 1 of myDocument
		set myXMLElementB to XML element 2 of myRootXMLElement
		set myAttribute to XML attribute 1 of myXMLElementB
		--Given an XML attribute "myAttribute" and an XML tag "myXMLTag"...
		tell myAttribute
			convert to element located element end markup tag myXMLTag
		end tell
		--Place the story so that you can see the result of the change.
		tell story 1 of myDocument
			place XML using myRootXMLElement
		end tell
	end tell
	--![Convert attribute to element.]
end mySnippet
to myTeardown()
end myTeardown
on myGetBounds(myDocument, myPage)
	tell application "Adobe InDesign 2024"
		tell document preferences of myDocument
			set myPageWidth to page width
			set myPageHeight to page height
		end tell
		tell margin preferences of myPage
			if side of myPage is left hand then
				set myX2 to left
				set myX1 to right
			else
				set myX1 to left
				set myX2 to right
			end if
			set myY1 to top
			set myY2 to bottom
		end tell
		set myX2 to myPageWidth - myX2
		set myY2 to myPageHeight - myY2
		return {myY1, myX1, myY2, myX2}
	end tell
end myGetBounds
