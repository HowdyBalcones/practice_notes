--UntagElement.applescript
--An InDesign AppleScript
--
--Shows how to untag an XML element.
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
				set myXMLElementA to make XML element with properties {markup tag:myXMLTag, contents:"A"}
				set myXMLElementB to make XML element with properties {markup tag:myXMLTag, contents:"B"}
				set myXMLElementC to make XML element with properties {markup tag:myXMLTag, contents:"C"}
				set myXMLElementD to make XML element with properties {markup tag:myXMLTag, contents:"D"}
				repeat with myCounter from 1 to 4
					tell myXMLElementD
						make XML element with properties {markup tag:myXMLTag, contents:(myCounter as string)}
					end tell
				end repeat
			end tell
			set myPage to page 1
			tell myPage
				set myTextFrame to make text frame with properties {geometric bounds:my myGetBounds(myDocument, myPage)}
			end tell
			tell myTextFrame to place XML using myRootXMLElement
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Untag XML element.]
		tell myDocument
			tell XML element -1 of XML element 1 to untag
		end tell
		--![Untag XML element.]
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
