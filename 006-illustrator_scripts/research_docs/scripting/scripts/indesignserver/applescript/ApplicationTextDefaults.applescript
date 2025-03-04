--ApplicationTextDefaults.applescript
--An InDesign Server AppleScript
--Sets the application text defaults, which will become the text defaults for all
--new documents. Existing documents will remain unchanged. Note that all of 
--these properties could be set using a single "with properties" statement--we've
--split them into separate statements here for the sake of clarity.
tell application "InDesignServer"
	set myBlackSwatch to color "Black"
	set myNoneSwatch to swatch "None"
	tell text defaults
		try
			set applied font to font "Minion Pro"
		end try
		try
			set font style to "Regular"
		end try
		try
			set applied language to "English: USA"
		end try
		set auto leading to 100
		set balance ragged lines to false
		set baseline shift to 0
		set capitalization to normal
		set composer to "Adobe Paragraph Composer"
		set desired glyph scaling to 100
		set desired letter spacing to 0
		set desired word spacing to 100
		set drop cap characters to 0
		if drop cap characters is not equal to 0 then
			set drop cap lines to 3
			--Assumes that the application has a default character style named "myDropCap"
			set drop cap style to character style "myDropCap"
		end if
		set fill color to myBlackSwatch
		set fill tint to 100
		set first line indent to "14pt"
		set gradient fill angle to 0
		set gradient fill length to 0
		set grid align first line only to false
		set horizontal scale to 100
		set hyphenation to true
		set hyphenate after first to 3
		set hyphenate before last to 4
		set hyphenate capitalized words to false
		set hyphenate ladder limit to 1
		set hyphenate words longer than to 5
		set hyphenation zone to "3p"
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
		set OTF discretionary ligature to true
		set OTF figure style to proportional oldstyle
		set OTF fraction to true
		set OTF ordinal to false
		set OTF slashed zero to false
		set OTF swash to false
		set OTF titling to false
		set overprint fill to false
		set overprint stroke to false
		set point size to 11
		set position to normal
		set right indent to 0
		set rule above to false
		if rule above is true then
			set rule above color to myBlackSwatch
			set rule above gap color to myNoneSwatch
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
		if rule below is true then
			set rule below color to color myBlackSwatch
			set rule below gap color to myNoneSwatch
			set rule below gap overPrint to false
			set rule below gap tint to 100
			set rule below left indent to 0
			set rule below line weight to 0.25
			set rule below offset to 14
			set rule below overPrint to false
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
		if strike thru is true then
			set strike through color to color myBlackSwatch
			set strike through gap color to myNoneSwatch
			set strike through gap overprint to false
			set strike through gap tint to 100
			set strike through offset to 3
			set strike through overprint to false
			set strike through tint to 100
			set strike through type to stroke style "Solid"
			set strike through weight to 0.25
		end if
		set stroke color to myNoneSwatch
		set stroke tint to 100
		set stroke weight to 0
		set tracking to 0
		set underline to false
		if underline is true then
			set underline color to color myBlackSwatch
			set underline gap color to myNoneSwatch
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
end tell
