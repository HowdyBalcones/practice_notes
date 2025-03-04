--CreateCharacterStyle.as
--An InDesign AppleScript
--
--Creates a complete character style based on the selected text.
--
--For more on InDesign/InCopy scripting see the documentation included in the Scripting SDK 
--available at http://www.adobe.com/devnet/indesign/sdk.html
--or visit the InDesign Scripting User to User forum at http://www.adobeforums.com.
--
tell application "Adobe InDesign 2024"
	set myTextObjects to {text, text frame, insertion point, character, word, text style range, line, paragraph, text column}
	if (count documents) > 0 then
		set mySelection to selection
		if (count mySelection) = 1 then
			if class of item 1 of mySelection is in myTextObjects then
				if class of item 1 of mySelection is text frame then
					if (count characters of item 1 of mySelection) is not 0 then
						set myText to object reference of character 1 of item 1 of mySelection
					else
						set myText to insertion point 1 of item 1 of mySelection
					end if
				else
					if class of item 1 of mySelection is not insertion point then
						set myText to object reference of character 1 of item 1 of mySelection
					else
						set myText to insertion point 1 of item 1 of mySelection
					end if
				end if
				set myCharacterStyleName to my myCreateCharacterStyle(myText)
				--Apply the character style to the selected text.
				if class of item 1 of mySelection is not text frame then
					set applied character style of item 1 of mySelection to character style myCharacterStyleName of active document
				else
					set applied character style of text 1 of item 1 of mySelection to character style myCharacterStyleName of active document
				end if
			else
				display dialog ("Please select some text (or a text frame) try again.")
			end if
		else
			display dialog ("Nothing is selected. Please select some text (or a text frame) try again.")
		end if
	else
		display dialog ("No documents are open. Please open a document and try again.")
	end if
end tell
on myCreateCharacterStyle(myText)
	tell application "Adobe InDesign 2024"
		set myProperties to properties of myText
		tell active document
			set myCharacterStyle to make character style
			tell myCharacterStyle
				set OTF slashed zero to OTF slashed zero of myProperties
				set OTF contextual alternate to OTF contextual alternate of myProperties
				set OTF discretionary ligature to OTF discretionary ligature of myProperties
				set OTF fraction to OTF fraction of myProperties
				set OTF ordinal to OTF ordinal of myProperties
				set OTF swash to OTF swash of myProperties
				set OTF titling to OTF titling of myProperties
				set OTF figure style to OTF figure style of myProperties
				set strike through overprint to strike through overprint of myProperties
				set baseline shift to baseline shift of myProperties
				set capitalization to capitalization of myProperties
				set fill tint to fill tint of myProperties
				set fill color to fill color of myProperties
				set applied font to applied font of myProperties
				set ligatures to ligatures of myProperties
				set stroke tint to stroke tint of myProperties
				set stroke color to stroke color of myProperties
				set stroke weight to stroke weight of myProperties
				set no break to no break of myProperties
				set overprint fill to overprint fill of myProperties
				set kerning method to kerning method of myProperties
				set horizontal scale to horizontal scale of myProperties
				set applied language to applied language of myProperties
				set position to position of myProperties
				set skew to skew of myProperties
				set font style to font style of myProperties
				set point size to point size of myProperties
				set vertical scale to vertical scale of myProperties
				set overprint stroke to overprint stroke of myProperties
				set strike thru to strike thru of myProperties
				if strike thru of myProperties is true then
					set strike through color to strike through color of myProperties
					set strike through gap color to strike through gap color of myProperties
					set strike through gap overprint to strike through gap overprint of myProperties
					set strike through gap tint to strike through gap tint of myProperties
					set strike through offset to strike through offset of myProperties
					set strike through type to strike through type of myProperties
					set strike through tint to strike through tint of myProperties
					set strike through weight to strike through weight of myProperties
				end if
				set leading to leading of myProperties
				set tracking to tracking of myProperties
				set underline to underline of myProperties
				if underline of myProperties is true then
					set underline color to underline color of myProperties
					set underline gap color to underline gap color of myProperties
					set underline gap tint to underline gap tint of myProperties
					set underline overprint to underline overprint of myProperties
					set underline offset to underline offset of myProperties
					set underline type to underline type of myProperties
					set underline tint to underline tint of myProperties
					set underline weight to underline weight of myProperties
					set underline gap overprint to underline gap overprint of myProperties
				end if
			end tell
		end tell
		return name of myCharacterStyle
	end tell
end myCreateCharacterStyle
