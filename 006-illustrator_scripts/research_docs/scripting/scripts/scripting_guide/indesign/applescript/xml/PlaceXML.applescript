--PlaceXML.applescript
--An InDesign AppleScript
--
--Places an XML element in a text frame.
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
			set myRootXMLElement to XML element 1
			set myXMLTag to make XML tag with properties {name:"xml_element"}
		end tell
		tell myRootXMLElement
			set myXMLElementA to make XML element with properties {markup tag:myXMLTag, contents:"This is a paragraph in an XML story."}
			set myXMLElementB to make XML element with properties {markup tag:myXMLTag, contents:"This is another paragraph in an XML story."}
			set myXMLElementC to make XML element with properties {markup tag:myXMLTag, contents:"This is the third paragraph in an XML story."}
			set myXMLElementD to make XML element with properties {markup tag:myXMLTag, contents:"This is the last paragraph in an XML story."}
		end tell
		set myPage to page 1 of myDocument
		tell myPage
			set myTextFrame to make text frame with properties {geometric bounds:my myGetBounds(myDocument, myPage)}
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Place XML.]
		set myPage to page 1 of myDocument
		set myTextFrame to text frame 1 of myPage
		tell myTextFrame to place XML using XML element 1 of myDocument
		--![Place XML.]
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
