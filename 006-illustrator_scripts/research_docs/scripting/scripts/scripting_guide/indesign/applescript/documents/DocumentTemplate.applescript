--DocumentTemplate.applescript
--An InDesign AppleScript
--
--Creates a document template, including master pages, layers, a color, paragraph and character styles, guides, and XMP information.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		--![Create document template.]
		--Set the application default margin preferences.
		tell margin preferences
			set myY1 to top
			set myX1 to left
			set myY2 to bottom
			set myX2 to right
			--Set the application default margin preferences.
			--Document baseline grid will be based on 14 points, and
			--all margins are set in increments of 14 points.
			set top to ((14 * 4) & "pt") as string
			set left to ((14 * 4) & "pt") as string
			set bottom to "74pt"
			set right to ((14 * 5) & "pt") as string
		end tell
		--Make a new document.
		set myDocument to make document
		--Reset the application default margin preferences.
		tell margin preferences
			set top to myY1
			set left to myX1
			set bottom to myY2
			set right to myX2
		end tell
		tell myDocument
			tell document preferences
				set page width to "7i"
				set page height to "9i"
				set page orientation to portrait
			end tell
			--Set up the bleed and slug areas.
			tell document preferences
				--Bleed
				set document bleed bottom offset to "3p"
				set document bleed top offset to "3p"
				set document bleed inside or left offset to "3p"
				set document bleed outside or right offset to "3p"
				--Slug
				set slug bottom offset to "18p"
				set slug top offset to "3p"
				set slug inside or left offset to "3p"
				set slug right or outside offset to "3p"
			end tell
			--Create a color.
			try
				set myColor to color "PageNumberRed"
			on error
				set myColor to make color with properties {name:"PageNumberRed", model:process, color value:{20, 100, 80, 10}}
			end try
			--Next, set up some default styles.
			--Create up a character style for the page numbers.
			try
				set myCharacterStyle to character style "page_number"
			on error
				set myCharacterStyle to make character style with properties {name:"page_number"}
			end try
			set fill color of myCharacterStyle to color "PageNumberRed"
			--Create a pair of paragraph styles for the page footer text.
			--These styles have only basic formatting.
			try
				set myParagraphStyle to paragraph style "footer_left"
			on error
				set myParagraphStyle to make paragraph style with properties {name:"footer_left"}
			end try
			--Create a paragraph style for the page footer text.
			try
				set myParagraphStyle to paragraph style "footer_right"
			on error
				set myParagraphStyle to make paragraph style with properties {name:"footer_right", based on:paragraph style "footer_left", justification:right align}
			end try
			--Create a layer for guides.
			try
				set myLayer to layer "GuideLayer"
			on error
				set myLayer to make layer with properties {name:"GuideLayer"}
			end try
			--Create a layer for the footer items.
			try
				set myLayer to layer "Footer"
			on error
				set myLayer to make layer with properties {name:"Footer"}
			end try
			--Create a layer for the slug items.
			try
				set myLayer to layer "Slug"
			on error
				set myLayer to make layer with properties {name:"Slug"}
			end try
			--Create a layer for the body text.
			try
				set myLayer to layer "BodyText"
			on error
				set myLayer to make layer with properties {name:"BodyText"}
			end try
			tell view preferences
				set ruler origin to page origin
				set horizontal measurement units to points
				set vertical measurement units to points
			end tell
			--Document baseline grid and document grid
			tell grid preferences
				set baseline start to 56
				set baseline division to 14
				set baseline grid shown to false
				set horizontal gridline division to 14
				set horizontal grid subdivision to 5
				set vertical gridline division to 14
				set vertical grid subdivision to 5
				set document grid shown to false
			end tell
			--Document XMP information.
			tell metadata preferences
				set author to "Olav Martin Kvern"
				set copyright info URL to "http:--www.adobe.com"
				set copyright notice to "This document is not copyrighted."
				set copyright status to no
				set description to "Example 7 x 9 book layout"
				set document title to "Example"
				set job name to "7 x 9 book layout template"
				set keywords to {"7 x 9", "book", "template"}
				set myNewContainer to create container item namespace "http://ns.adobe.com/xap/1.0/" path "email"
				set property namespace "http://ns.adobe.com/xap/1.0/" path "email/*[1]" value "okvern@adobe.com"
			end tell
			set myPageHeight to page height of document preferences
			set myPageWidth to page width of document preferences
			--Set up the master spread.
			tell master spread 1
				tell page 1
					tell margin preferences
						--For a facing pages spread, the "left" margin is the inside
						--margin; the "right" margin is the outside margin.
						set myInsideMargin to left
						set myOutsideMargin to right
						set myTopMargin to top
						set myBottomMargin to bottom
					end tell
					set myBottomMargin to myPageHeight - myBottomMargin
					set myInsideMargin to myPageWidth - myInsideMargin
					make guide with properties {orientation:vertical, location:myInsideMargin, item layer:layer "GuideLayer" of myDocument}
					make guide with properties {orientation:vertical, location:myOutsideMargin, item layer:layer "GuideLayer" of myDocument}
					make guide with properties {orientation:horizontal, location:myTopMargin, item layer:layer "GuideLayer" of myDocument, fit to page:false}
					make guide with properties {orientation:horizontal, location:myBottomMargin, item layer:layer "GuideLayer" of myDocument, fit to page:false}
					make guide with properties {orientation:horizontal, location:myBottomMargin + 14, item layer:layer "GuideLayer" of myDocument, fit to page:false}
					make guide with properties {orientation:horizontal, location:myBottomMargin + 28, item layer:layer "GuideLayer" of myDocument, fit to page:false}
					set myLeftFooter to make text frame with properties {item layer:layer "Footer" of myDocument, geometric bounds:{myBottomMargin + 14, myOutsideMargin, myBottomMargin + 28, myInsideMargin}}
					set contents of insertion point 1 of parent story of myLeftFooter to section marker
					set contents of insertion point 1 of parent story of myLeftFooter to Em space
					set contents of insertion point 1 of parent story of myLeftFooter to auto page number
					set applied character style of character 1 of parent story of myLeftFooter to character style "page_number" of myDocument
					set applied paragraph style of paragraph 1 of parent story of myLeftFooter to paragraph style "footer_left" of myDocument
					--Slug information.
					tell metadata preferences of myDocument
						set myEmail to get property namespace "http://ns.adobe.com/xap/1.0/" path "email/*[1]"
						set myDate to current date
						set myString to "Author:" & tab & author & tab & "Description:" & tab & description & return & "Creation Date:" & tab & myDate & tab & "Email Contact" & tab & myEmail
					end tell
					set myLeftSlug to make text frame with properties {item layer:layer "Slug" of myDocument, geometric bounds:{myPageHeight + 36, myOutsideMargin, myPageHeight + 144, myInsideMargin}, contents:myString}
					tell parent story of myLeftSlug
						convert to table text 1
					end tell
					--Body text master text frame.
					set myLeftFrame to make text frame with properties {item layer:layer "BodyText" of myDocument, geometric bounds:{myTopMargin, myOutsideMargin, myBottomMargin, myInsideMargin}}
				end tell
				tell page 2
					tell margin preferences
						--For a facing pages spread, the "left" margin is the inside
						--margin; the "right" margin is the outside margin.
						set myOutsideMargin to left
						set myInsideMargin to right
					end tell
					set myOutsideMargin to myPageWidth - myOutsideMargin
					make guide with properties {orientation:vertical, location:myInsideMargin, item layer:layer "GuideLayer" of myDocument}
					make guide with properties {orientation:vertical, location:myOutsideMargin, item layer:layer "GuideLayer" of myDocument}
					set myRightFooter to make text frame with properties {item layer:layer "Footer" of myDocument, geometric bounds:{myBottomMargin + 14, myInsideMargin, myBottomMargin + 28, myOutsideMargin}}
					set contents of insertion point 1 of parent story of myRightFooter to auto page number
					set contents of insertion point 1 of parent story of myRightFooter to Em space
					set contents of insertion point 1 of parent story of myRightFooter to section marker
					set applied character style of character -1 of parent story of myRightFooter to character style "page_number" of myDocument
					set applied paragraph style of paragraph 1 of parent story of myRightFooter to paragraph style "footer_right" of myDocument
					--Slug information.
					set myRightSlug to make text frame with properties {item layer:layer "Slug" of myDocument, geometric bounds:{myPageHeight + 36, myInsideMargin, myPageHeight + 144, myOutsideMargin}, contents:myString}
					tell parent story of myRightSlug
						convert to table text 1
					end tell
					--Body text master text frame.
					set myRightFrame to make text frame with properties {item layer:layer "BodyText" of myDocument, geometric bounds:{myTopMargin, myInsideMargin, myBottomMargin, myOutsideMargin}}
				end tell
			end tell
			--Add section marker text--this text will appear in the footer.
			set marker of section 1 of myDocument to "Section 1"
			--When you link the master page text frames, one of the frames sometimes becomes selected. Deselect it.
			select nothing
		end tell
		--![Create document template.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
