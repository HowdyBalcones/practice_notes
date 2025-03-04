--MapTagsToStyles.applescript
--An InDesign AppleScript
--
--Demonstrates tag to style mapping.
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
			set myPage to page 1
			tell myPage
				set myTextFrame to make text frame with properties {geometric bounds:my myGetBounds(myDocument, myPage)}
				set myStory to parent story of myTextFrame
			end tell
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Map tags to styles.]
		tell myDocument
			set myPage to page 1
			--Create a tag to style mapping.
			make XML import map with properties {markup tag:"heading_1", mapped style:"heading 1"}
			make XML import map with properties {markup tag:"heading_2", mapped style:"heading 2"}
			make XML import map with properties {markup tag:"para_1", mapped style:"para 1"}
			make XML import map with properties {markup tag:"body_text", mapped style:"body text"}
			--Map the XML tags to the defined styles.
			map XML tags to styles
			--Place the story so that you can see the result of the mapping.
			tell story 1
				place XML using XML element 1 of myDocument
			end tell
		end tell
		--![Map tags to styles.]
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
