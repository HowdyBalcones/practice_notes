--UntagElement.applescripttell application "Adobe InCopy 2024"tell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Shows how to untag an XML element.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
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
			tell story 1
				place XML using XML element 1 of myDocument
			end tell
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InCopy 2024"
		set myDocument to document 1
		tell myDocument
			tell XML element -1 of XML element 1 to untag
		end tell
	end tell
end mySnippet
on myTeardown()
end myTeardown
