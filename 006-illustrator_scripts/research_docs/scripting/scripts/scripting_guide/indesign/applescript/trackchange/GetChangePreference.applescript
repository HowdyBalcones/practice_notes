--GetChangePreference.applescript
--An InDesign AppleScript
--
--Shows Shows how to get Track change preference.

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
		--![Preferences for tracking changes.]
		set myTrackChangesPreference to track changes preferences
		tell myTrackChangesPreference
			--  added background color choice (change background uses galley background color/change background uses user color/change background uses change pref color) : The background color option for added text.
			set myAddedBackgroundColorChoice to added background color choice
			set added background color choice to change background uses change pref color
			
			
			--added text color choice (change uses galley text color/change uses change pref color) : The color option for added text.
			set myAddedTextColorChoice to added text color choice
			set added text color choice to change uses change pref color
			
			
			--background color for added text (any) : The background color for added text, specified as an InDesign UI color. Note: Valid only when added background color choice is change background uses change pref color. Can return: list of 3 fixed (0 - 255) or canary/lemon/electrolyte/lime/forest/lichen/...
			set myBackgroundColorForAddedText to background color for added text
			set background color for added text to gray
			
			--background color for deleted text (any) : The background color for deleted text, specified as an InDesign UI color. Note: Valid only when deleted background color choice is change background uses change pref color. Can return: list of 3 fixed (0 - 255) or canary/lemon/electrolyte/lime/forest/lic...
			set myBackgroundColorForDeletedText to background color for deleted text
			set background color for deleted text to red
			
			--background color for moved text (any) : The background color for moved text, specified as an InDesign UI color. Note: Valid only when moved background color choice is change background uses change pref color. Can return: list of 3 fixed (0 - 255) or canary/lemon/electrolyte/lime/forest/lichen/...			
			set myBackgroundColorForMovedText to background color for moved text
			set background color for moved text to pink
			--change bar color (any) : The change bar color, specified as an InDesign UI color. 
			set myChangeBarColor to change bar color
			set change bar color to charcoal
			--deleted background color choice (change background uses galley background color/change background uses user color/change background uses change pref color) : The background color option for deleted text.
			set myDeletedBackgroundColorChoice to deleted background color choice
			set deleted background color choice to change background uses change pref color
			
			--deleted text color choice (change uses galley text color/change uses change pref color) : The color option for deleted text.
			set myDeletedTextColorChoice to deleted text color choice
			set deleted text color choice to change uses change pref color
			
			--location for change bar (left align/right align) : The change bar location.
			set myLocationForChangeBar to location for change bar
			set location for change bar to left align
			
			--marking for added text (none/strikethrough/underline single/outline) : The marking that identifies added text.
			set myMarkingForAddedText to marking for added text
			set marking for added text to strikethrough
			
			--marking for deleted text (none/strikethrough/underline single/outline) : The marking that identifies deleted text.
			set myMarkingForDeletedText to marking for deleted text
			set marking for deleted text to underline single
			
			--marking for moved text (none/strikethrough/underline single/outline) : The marking that identifies moved text.
			set myMarkingForMovedText to marking for moved text
			set marking for moved text to outline
			
			
			--moved background color choice (change background uses galley background color/change background uses user color/change background uses change pref color) : The background color option for moved text.
			set myMovedBackgroundColorChoice to moved background color choice
			set moved background color choice to change background uses galley background color
			
			-- moved text color choice (change uses galley text color/change uses change pref color) : The color option for moved text.
			set myMovedTextColorChoice to moved text color choice
			set moved text color choice to change uses change pref color
			
			-- If true, displays added text.
			set myShowAddedText to show added text
			set show added text to true
			
			--  If true, displays change bars.
			set myShowChangeBars to show change bars
			set show change bars to true
			
			-- If true, displays deleted text.
			set myShowDeletedText to show deleted text
			set show deleted text to true
			
			-- If true, displays moved text.
			set myShowMovedText to show moved text
			set show moved text to true
			
			-- If true, includes deleted text when using the Spell Check command.
			set mySpellCheckDeletedText to spell check deleted text
			set spell check deleted text to true
			
			--The color for added text, specified as an InDesign UI color. Note: Valid only when added text color choice is change uses change pref color. Can return: list of 3 fixed (0 - 255) or canary/lemon/electrolyte/lime/forest/lichen/jade/aqua/cirrus/ether/slate....	
			set myTextColorForAddedText to text color for added text
			set text color for added text to blue
			
			--  text color for deleted text (any) : The color for deleted text, specified as an InDesign UI color. Note: Valid only when deleted text color choice is change uses change pref color. Can return: list of 3 fixed (0 - 255) or canary/lemon/electrolyte/lime/forest/lichen/jade/aqua/cirrus/ether/s...			
			set myTextColorForDeletedText to text color for deleted text
			set text color for deleted text to yellow
			
			--  The color for moved text, specified as an InDesign UI color. Note: Valid only when moved text color choice is change uses change pref color. Can return: list of 3 fixed (0 - 255) or canary/lemon/electrolyte/lime/forest/lichen/jade/aqua/cirrus/ether/slate...
			set myTextColorForMovedText to text color for moved text
			set text color for moved text to green
		end tell
		--![Preferences for tracking changes.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
