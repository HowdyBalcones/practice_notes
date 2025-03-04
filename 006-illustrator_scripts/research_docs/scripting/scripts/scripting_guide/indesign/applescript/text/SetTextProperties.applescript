--SetTextProperties.applescript
--An InDesign AppleScript
--
--Shows how to set all read/write properties of a text object.
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
			set myPage to page 1
			tell myPage
				set myTextFrame to make text frame with properties {geometric bounds:my myGetBounds(myDocument, myPage), contents:placeholder text}
			end tell
		end tell
		set myStory to parent story of myTextFrame
		set contents of myStory to "x"
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Set text properties.]
		--Given a document "myDocument" containing a story...
		set myStory to story 1 of myDocument
		tell character 1 of myStory
			set align to baseline to false
			set applied character style to character style "[None]" of myDocument
			set applied font to "Minion Pro	Regular"
			set applied language to "English: USA"
			set applied numbering list to "[Default]"
			set applied paragraph style to paragraph style "[No Paragraph Style]" of myDocument
			set auto leading to 120
			set balance ragged lines to no balancing
			set baseline shift to 0
			set bullets alignment to left align
			set bullets and numbering list type to no list
			set bullets character style to character style "[None]" of myDocument
			set bullets text after to "^t"
			set capitalization to normal
			set composer to "Adobe Paragraph Composer"
			set desired glyph scaling to 100
			set desired letter spacing to 0
			set desired word spacing to 100
			set drop cap characters to 0
			set drop cap lines to 0
			set drop cap style to character style "[None]" of myDocument
			set dropcap detail to 0
			set fill color to color "Black" of myDocument
			set fill tint to -1
			set first line indent to 0
			set font style to "Regular"
			set gradient fill angle to 0
			set gradient fill length to -1
			set gradient fill start to [0, 0]
			set gradient stroke angle to 0
			set gradient stroke length to -1
			set gradient stroke start to [0, 0]
			set grid align first line only to false
			set horizontal scale to 100
			set hyphen weight to 5
			set hyphenate across columns to true
			set hyphenate after first to 2
			set hyphenate before last to 2
			set hyphenate capitalized words to true
			set hyphenate ladder limit to 3
			set hyphenate last word to true
			set hyphenate words longer than to 5
			set hyphenation to true
			set hyphenation zone to 3
			set ignore edge alignment to false
			set justification to left align
			set keep all lines together to false
			set keep first lines to 2
			set keep last lines to 2
			set keep lines together to false
			set keep rule above in frame to false
			set keep with next to 0
			set kerning method to "Optical"
			set last line indent to 0
			set leading to 12
			set left indent to 0
			set ligatures to true
			set maximum glyph scaling to 100
			set maximum letter spacing to 0
			set maximum word spacing to 133
			set minimum glyph scaling to 100
			set minimum letter spacing to 0
			set minimum word spacing to 80
			set no break to false
			set numbering alignment to left align
			set numbering apply restart policy to true
			set numbering character style to character style "[None]" of myDocument
			set numbering continue to true
			set numbering expression to "^#.^t"
			set numbering format to "1, 2, 3, 4..."
			set numbering level to 1
			set numbering start at to 1
			set OTF contextual alternate to true
			set OTF discretionary ligature to false
			set OTF figure style to proportional lining
			set OTF fraction to false
			set OTF historical to false
			set OTF locale to true
			set OTF mark to true
			set OTF ordinal to false
			set OTF slashed zero to false
			set OTF stylistic sets to 0
			set OTF swash to false
			set OTF titling to false
			set overprint fill to false
			set overprint stroke to false
			set point size to 72
			set position to normal
			set positional form to none
			set right indent to 0
			set rule above to false
			set rule above color to "Text Color"
			set rule above gap color to swatch "None" of myDocument
			set rule above gap overprint to false
			set rule above gap tint to 100
			set rule above left indent to 0
			set rule above line weight to 0.25
			set rule above offset to 14
			set rule above overprint to false
			set rule above right indent to 0
			set rule above tint to 100
			set rule above type to stroke style "Solid" of myDocument
			set rule above width to column width
			set rule below to false
			set rule below color to "Text Color"
			set rule below gap color to swatch "None" of myDocument
			set rule below gap overprint to false
			set rule below gap tint to 100
			set rule below left indent to 0
			set rule below line weight to 0.25
			set rule below offset to 14
			set rule below overprint to false
			set rule below right indent to 0
			set rule below tint to 100
			set rule below type to stroke style "Solid" of myDocument
			set rule below width to column width
			set single word justification to left align
			set skew to 0
			set space after to 0
			set space before to 0
			set start paragraph to anywhere
			set strike thru to false
			set strike through color to color "Black" of myDocument
			set strike through gap color to swatch "None" of myDocument
			set strike through gap overprint to false
			set strike through gap tint to 100
			set strike through offset to 3
			set strike through overprint to false
			set strike through tint to 100
			set strike through type to stroke style "Solid" of myDocument
			set strike through weight to 0.25
			set stroke color to swatch "None" of myDocument
			set stroke tint to -1
			set stroke weight to 1
			set tracking to 0
			set tracking to 0
			set underline to false
			set underline color to color "Black" of myDocument
			set underline gap color to swatch "None" of myDocument
			set underline gap overprint to false
			set underline gap tint to 100
			set underline offset to 3
			set underline overprint to false
			set underline tint to 100
			set underline type to stroke style "Solid" of myDocument
			set underline weight to 0.25
			set vertical scale to 100
		end tell
		--![Set text properties.]
	end tell
end mySnippet
to myTeardown()
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
