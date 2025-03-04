--InsertTextAsContent.applescript
--An InCopy AppleScript
--
--Shows how to add text before, after, and at the beginning/end of
--XML elements.
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
				set myXMLElementA to make XML element with properties {markup tag:myXMLTag}
				set contents of myXMLElementA to "This is a paragraph in an XML story."
				set myXMLElementB to make XML element with properties {markup tag:myXMLTag}
				set contents of myXMLElementB to "This is a another paragraph in an XML story."
				set myXMLElementC to make XML element with properties {markup tag:myXMLTag}
				set contents of myXMLElementC to "This is the third paragraph in an XML story."
				set myXMLElementD to make XML element with properties {markup tag:myXMLTag}
				set contents of myXMLElementD to "This is the last paragraph in an XML story."
				tell myXMLElementA
					--By inserting the return character after the XML element, the
					--character becomes part of the content of the parent XML element,
					--and not part of the content of the XML element itself.
					insert text as content using return position after element
				end tell
				tell myXMLElementB
					insert text as content using "Static text: " position before element
					insert text as content using return position after element
				end tell
				tell myXMLElementC
					insert text as content using "Text at the start of an element: " position element start
					insert text as content using " Text at the end of an element. " position element end
				end tell
				tell myXMLElementD
					insert text as content using "Text before the element: " position before element
					insert text as content using " Text after the element. " position after element
				end tell
			end tell
			tell story 1
				place XML using myRootXMLElement
			end tell
		end tell
	end tell
end mySnippet
on myTeardown()
end myTeardown
