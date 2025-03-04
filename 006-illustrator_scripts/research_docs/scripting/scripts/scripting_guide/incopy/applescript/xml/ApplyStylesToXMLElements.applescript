--ApplyStylesToXMLElements.applescripttell application "Adobe InCopy 2024"tell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Shows how to apply paragraph and character styles to XML elements
--without using tag to style/style to tag mapping.
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
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InCopy 2024"
		set myDocument to document 1
		tell myDocument
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
			--Create a character style.
			set myCharacterStyle to make character style with properties {name:"Emphasis", font style:"Italic"}
			--Add XML elements.
			set myRootXMLElement to XML element 1
			tell myRootXMLElement
				set myXMLElementA to make XML element with properties {markup tag:myHeading1XMLTag, contents:"Heading 1"}
				tell myXMLElementA
					insert text as content using return position after element
					apply paragraph style using myHeading1Style clearing overrides yes
				end tell
				set myXMLElementB to make XML element with properties {markup tag:myPara1XMLTag, contents:"This is the first paragraph in the article."}
				tell myXMLElementB
					insert text as content using return position after element
					apply paragraph style using myPara1Style clearing overrides yes
				end tell
				set myXMLElementC to make XML element with properties {markup tag:myBodyTextXMLTag, contents:"This is the second paragraph in the article."}
				tell myXMLElementC
					insert text as content using return position after element
					apply paragraph style using myBodyTextStyle clearing overrides yes
				end tell
				set myXMLElementD to make XML element with properties {markup tag:myHeading2XMLTag, contents:"Heading 2"}
				tell myXMLElementD
					insert text as content using return position after element
					apply paragraph style using myHeading2Style clearing overrides yes
				end tell
				set myXMLElementE to make XML element with properties {markup tag:myPara1XMLTag, contents:"This is the first paragraph following the subhead."}
				tell myXMLElementE
					insert text as content using return position after element
					apply paragraph style using myPara1Style clearing overrides yes
				end tell
				set myXMLElementF to make XML element with properties {markup tag:myBodyTextXMLTag, contents:"Note:"}
				tell myXMLElementF
					insert text as content using " " position after element
					apply character style using myCharacterStyle
				end tell
				set myXMLElementG to make XML element with properties {markup tag:myBodyTextXMLTag, contents:"This is the second paragraph following the subhead."}
				tell myXMLElementG
					insert text as content using return position after element
					apply paragraph style using myBodyTextStyle clearing overrides no
				end tell
			end tell
		end tell
		--Place the story so that you can see the result of the change.
		tell story 1 of myDocument
			place XML using myRootXMLElement
		end tell
	end tell
end mySnippet
on myTeardown()
end myTeardown
