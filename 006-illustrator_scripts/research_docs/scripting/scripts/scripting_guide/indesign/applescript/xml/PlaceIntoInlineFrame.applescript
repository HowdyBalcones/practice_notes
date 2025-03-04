--PlaceIntoInlineFrame.applescript
--An InDesign AppleScript
--
--The place into inline frame command adds an inline
--frame at the XML element's location in text and adds
--the content of the XML element to the frame.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		set myPage to active page of active window
		tell myDocument
			tell view preferences
				set horizontal measurement units to points
				set vertical measurement units to points
			end tell
			set myRootXMLElement to XML element 1
			set myXMLTag to make XML tag with properties {name:"xml_element"}
		end tell
		tell myRootXMLElement
			set myXMLElementA to make XML element with properties {markup tag:myXMLTag, contents:"This is a paragraph in an XML story."}
			set myXMLElementB to make XML element with properties {markup tag:myXMLTag, contents:"This is another paragraph in an XML story."}
			set myXMLElementC to make XML element with properties {markup tag:myXMLTag, contents:"This is the third paragraph in an XML story."}
			set myXMLElementD to make XML element with properties {markup tag:myXMLTag, contents:"This is the last paragraph in an XML story."}
		end tell
		tell myPage
			set myTextFrame to make text frame with properties {geometric bounds:my myGetBounds(myDocument, myPage)}
		end tell
		tell myTextFrame to place XML using myRootXMLElement
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Place into inline frame.]
		--place into frame has one parameter, dimensions, which define
		--the width and height of the inline frame.
		tell XML element 3 of XML element 1 of myDocument
			place into inline frame dimensions {72, 24}
		end tell
		--![Place into inline frame.]
	end tell
end mySnippet
on myTeardown()
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
