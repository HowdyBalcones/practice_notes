--MapStylesToTags.applescript
--An InDesign AppleScript
--
--Demonstrates style to tag mapping.
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
			set horizontal measurement units of view preferences to points
			set vertical measurement units of view preferences to points
			set myRootXMLElement to XML element 1
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
			tell myPage
				set myTextFrame to make text frame with properties {geometric bounds:my myGetBounds(myDocument, myPage)}
			end tell
			set myStory to parent story of myTextFrame
			tell myStory
				set contents of insertion point -1 to "Heading 1" & return
				tell paragraph -1 to apply paragraph style using myHeading1Style with clearing overrides
				set contents of insertion point -1 to "This is the first paragraph in the article." & return
				tell paragraph -1 to apply paragraph style using myPara1Style with clearing overrides
				set contents of insertion point -1 to "This is the second paragraph in the article." & return
				tell paragraph -1 to apply paragraph style using myBodyTextStyle with clearing overrides
				set contents of insertion point -1 to "Heading 2" & return
				tell paragraph -1 to apply paragraph style using myHeading2Style with clearing overrides
				set contents of insertion point -1 to "This is the first paragraph following the subhead." & return
				tell paragraph -1 to apply paragraph style using myPara1Style with clearing overrides
				set contents of insertion point -1 to "This is the second paragraph following the subhead." & return
				tell paragraph -1 to apply paragraph style using myBodyTextStyle with clearing overrides
			end tell
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Map styles to tags.]
		tell myDocument
			--Create a tag to style mapping.
			make XML export map with properties {markup tag:"heading_1", mapped style:"heading 1"}
			make XML export map with properties {markup tag:"heading_2", mapped style:"heading 2"}
			make XML export map with properties {markup tag:"para_1", mapped style:"para 1"}
			make XML export map with properties {markup tag:"body_text", mapped style:"body text"}
			--Apply the style to tag mapping.
			map styles to XML tags
		end tell
		--![Map styles to tags.]
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
