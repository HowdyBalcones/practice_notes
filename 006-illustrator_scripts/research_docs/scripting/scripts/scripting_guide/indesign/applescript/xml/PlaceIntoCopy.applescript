--PlaceIntoCopy.applescript
--An InDesign AppleScript
--
--Associate an XML element with an inline page item (i.e., an anchored object)
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		tell view preferences of myDocument
			set horizontal measurement units to points
			set vertical measurement units to points
			set ruler origin to page origin
		end tell
		tell myDocument
			set myRootXMLElement to XML element 1
			set myXMLTag to make XML tag with properties {name:"xml_element"}
		end tell
		tell myRootXMLElement
			set myXMLElementA to make XML element with properties {markup tag:myXMLTag, contents:"This is a paragraph in an XML story."}
			set myXMLElementB to make XML element with properties {markup tag:myXMLTag, contents:"This is another paragraph in an XML story."}
			set myXMLElementC to make XML element with properties {markup tag:myXMLTag, contents:"This is the third paragraph in an XML story."}
			set myXMLElementD to make XML element with properties {markup tag:myXMLTag, contents:"This is the last paragraph in an XML story."}
		end tell
		tell page 1 of myDocument
			set myTextFrame to make text frame with properties {geometric bounds:{72, 72, 144, 144}}
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		set myPage to page 1 of myDocument
		set myTextFrame to text frame 1 of myPage
		--![Place into copy.]
		--Given a document "myDocument"...
		tell XML element 1 of myDocument
			set myFrame to place into copy on myPage place point {288, 72} copy item myTextFrame
		end tell
		--![Place into copy.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
