--ConvertXMLElementToTable.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Shows how to convert an XML element to a table.
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
			--Create a series of XML tags.
			set myRowTag to make XML tag with properties {name:"Row"}
			set myCellTag to make XML tag with properties {name:"Cell"}
			set myTableTag to make XML tag with properties {name:"Table"}
			--Add XML elements.
			set myRootXMLElement to XML element 1
			tell myRootXMLElement
				set myTableXMLElement to make XML element with properties {markup tag:myTableTag}
				tell myTableXMLElement
					repeat with myRowCounter from 1 to 6
						set myXMLRow to make XML element with properties {markup tag:myRowTag}
						tell myXMLRow
							set myString to "Row " & myRowCounter
							repeat with myCellCounter from 1 to 4
								make XML element with properties {markup tag:myCellTag, contents:myString & ":Cell " & myCellCounter}
							end repeat
						end tell
					end repeat
					convert element to table row tag myRowTag cell tag myCellTag
				end tell
			end tell
			--Place the story so that you can see the result of the change.
			tell story 1 of myDocument
				place XML using XML element 1 of myDocument
			end tell
		end tell
	end tell
end mySnippet
on myTeardown()
end myTeardown


