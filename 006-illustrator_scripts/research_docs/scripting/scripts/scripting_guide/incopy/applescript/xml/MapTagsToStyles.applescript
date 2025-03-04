--MapTagsToStyles.applescripttell application "Adobe InCopy 2024"tell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Demonstrates tag to style mapping.
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
			set horizontal measurement units of view preferences to points
			set vertical measurement units of view preferences to points
			--Create a series of XML tags.
			set myHeading1XMLTag to make XML tag with properties {name:"heading_1"}
			set myHeading2XMLTag to make XML tag with properties {name:"heading_2"}
			set myPara1XMLTag to make XML tag with properties {name:"para_1"}
			set myBodyTextXMLTag to make XML tag with properties {name:"body_text"}
			--Create a series of paragraph styles.
			set myHeading1Style to make paragraph style with properties {name:"heading 1", point size:24}
			set myHeading2Style to make paragraph style with properties {name:"heading 2", point size:14, space before:12}
			set myPara1Style to make paragraph style with properties {name:"para 1", point size:12, first line indent:0}
			set myBodyTextStyle to make paragraph style with properties {name:"body text", point size:12, first line indent:24}
			--Add XML elements.
			set myRootXMLElement to XML element 1
			tell myRootXMLElement
				set myXMLElementA to make XML element with properties {markup tag:myHeading1XMLTag, contents:"Heading 1"}
				tell myXMLElementA
					insert text as content using return position after element
				end tell
				set myXMLElementB to make XML element with properties {markup tag:myPara1XMLTag, contents:"This is the first paragraph in the article."}
				tell myXMLElementB
					insert text as content using return position after element
				end tell
				set myXMLElementC to make XML element with properties {markup tag:myBodyTextXMLTag, contents:"This is the second paragraph in the article."}
				tell myXMLElementC
					insert text as content using return position after element
				end tell
				set myXMLElementD to make XML element with properties {markup tag:myHeading2XMLTag, contents:"Heading 2"}
				tell myXMLElementD
					insert text as content using return position after element
				end tell
				set myXMLElementE to make XML element with properties {markup tag:myPara1XMLTag, contents:"This is the first paragraph following the subhead."}
				tell myXMLElementE
					insert text as content using return position after element
				end tell
				set myXMLElementF to make XML element with properties {markup tag:myBodyTextXMLTag, contents:"This is the second paragraph following the subhead."}
				tell myXMLElementF
					insert text as content using return position after element
				end tell
			end tell
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InCopy 2024"
		set myDocument to document 1
		tell myDocument
			--Create a tag to style mapping.
			make XML import map with properties {markup tag:"heading_1", mapped style:"heading 1"}
			make XML import map with properties {markup tag:"heading_2", mapped style:"heading 2"}
			make XML import map with properties {markup tag:"para_1", mapped style:"para 1"}
			make XML import map with properties {markup tag:"body_text", mapped style:"body text"}
			--Apply the xML tag to style mapping
			map XML tags to styles
		end tell
		--Place the story so that you can see the result of the change.
		tell story 1 of myDocument
			place XML using XML element 1 of myDocument
		end tell
	end tell
end mySnippet
on myTeardown()
end myTeardown
