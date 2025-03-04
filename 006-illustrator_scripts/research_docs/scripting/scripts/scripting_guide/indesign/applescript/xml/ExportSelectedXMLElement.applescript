--ExportXML.applescript
--An InDesign AppleScript
--
--Shows how to export the XML structure of a document.
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
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to active document
		--![Export selected XML element.]
		tell myDocument
			set export from selected of XML export preferences to true
			select XML element -1 of XML element 1
			export to "yukino:selectedXMLElement.xml" format "XML"
			set export from selected of XML export preferences to false
		end tell
		--![Export selected XML element.]
	end tell
end mySnippet
to myTeardown()
end myTeardown
