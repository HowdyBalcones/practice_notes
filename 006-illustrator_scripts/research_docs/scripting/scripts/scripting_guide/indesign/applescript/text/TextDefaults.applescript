--TextDefaults.applescript
--An InDesign AppleScript
--
--Sets the text defaults of the application, which set the default formatting
--for all new documents. Existing text frames are unaffected. 
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
		--![Text defaults.]
		set horizontal measurement units of view preferences to points
		set vertical measurement units of view preferences to points
		--To set the text formatting defaults for a document, replace "app" 
		--in the following lines with a reference to a document.
		tell text defaults
			set alignToBaseline to true
			--Because the font might not be available, it's usually best
			--to apply the font within a try...catch structure. Fill in the
			--name of a font on your system.
			try
				set appliedFont to font "Minion Pro"
			end try
			--Because the font style might not be available, it's usually best
			--to apply the font style within a try...catch structure.
			try
				set font style to "Regular"
			end try
			--Because the language might not be available, it's usually best
			--to apply the language within a try...catch structure.
			try
				set applied language to "English: USA"
			end try
			set autoLeading to 100
			set balsanceRaggedLines to false
			set baselineShift to 0
			set capitalization to normal
			set composer to "Adobe Paragraph Composer"
			set desiredGlyphScaling to 100
			set desiredLetterSpacing to 0
			set desiredWordSpacing to 100
			set drop cap characters to 0
			if drop cap characters is not equal to 0 then
				dropCapLines to 3
				--Assumes that the application has a default character style named "myDropCap"
				set drop cap style to character style "myDropCap"
			end if
			set fill color to "Black"
			set fill tint to 100
			set first line indent to 14
			set grid align first line only to false
			set horizontal scale to 100
			set hyphenate after first to 3
			set hyphenate before last to 4
			set hyphenate capitalized words to false
			set hyphenate ladder limit to 1
			set hyphenate words longer than to 5
			set hyphenation to true
			set hyphenation zone to 36
			set hyphen weight to 9
			set justification to left align
			set keep all lines together to false
			set keep lines together to true
			set keep first lines to 2
			set keep last lines to 2
			set keep with next to 0
			set kerning method to "Optical"
			set leading to 14
			set left indent to 0
			set ligatures to true
			set maximum glyph scaling to 100
			set maximum letter spacing to 0
			set maximum word spacing to 160
			set minimum glyph scaling to 100
			set minimum letter spacing to 0
			set minimum word spacing to 80
			set no break to false
			set OTF contextual alternate to true
			set OTF discretionary ligature to false
			set OTF figure style to proportional oldstyle
			set OTF fraction to true
			set OTF historical to false
			set OTF ordinal to false
			set OTF slashed zero to false
			set OTF swash to false
			set OTF titling to false
			set overprint fill to false
			set overprint stroke to false
			set pointSize to 11
			set position to normal
			set right indent to 0
			set rule above to false
			if rule above = true then
				set rule above color to color "Black"
				set rule above gap color to swatch "None"
				set rule above gap overprint to false
				set rule above gap tint to 100
				set rule above left indent to 0
				set rule above line weight to 0.25
				set rule above offset to 14
				set rule above overprint to false
				set rule above right indent to 0
				set rule above tint to 100
				set rule above type to stroke style "Solid"
				set rule above width to column width
			end if
			set rule below to false
			if rule below = true then
				set rule below color to color "Black"
				set rule below gap color to swatch "None"
				set rule below gap overprint to false
				set rule below gap tint to 100
				set rule below left indent to 0
				set rule below line weight to 0.25
				set rule below offset to 14
				set rule below overprint to false
				set rule below right indent to 0
				set rule below tint to 100
				set rule below type to stroke style "Solid"
				set rule below width to column width
			end if
			set single word justification to left align
			set skew to 0
			set space after to 0
			set space before to 0
			set start paragraph to anywhere
			set strike thru to false
			if strike thru = true then
				set strike through color to color "Black"
				set strike through gap color to swatch "None"
				set strike through gap overprint to false
				set strike through gap tint to 100
				set strike through offset to 3
				set strike through overprint to false
				set strike through tint to 100
				set strike through type to stroke style "Solid"
				set strike through weight to 0.25
			end if
			set stroke color to "None"
			set stroke tint to 100
			set stroke weight to 0
			set tracking to 0
			set underline to false
			if underline = true then
				set underline color to color "Black"
				set underline gap color to swatch "None"
				set underline gap overprint to false
				set underline gap tint to 100
				set underline offset to 3
				set underline overprint to false
				set underline tint to 100
				set underline type to stroke style "Solid"
				set underline weight to 0.25
			end if
			set vertical scale to 100
		end tell
		--![Text defaults.]
	end tell
end mySnippet
to myTeardown()
end myTeardown
