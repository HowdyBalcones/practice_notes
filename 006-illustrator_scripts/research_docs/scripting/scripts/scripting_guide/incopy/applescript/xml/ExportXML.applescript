--ExportXML.applescript
--An InCopy AppleScript
--
--Shows how to export the XML structure of a document.
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
			--Place the XML root element so that you can see the result in the Structure panel.
			tell story 1
				place XML using myRootXMLElement
			end tell
			export to "Macintosh HD:c:test.xml" format "XML"
		end tell
	end tell
end mySnippet
on myTeardown()
end myTeardown

