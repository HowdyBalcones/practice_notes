--PrintPreferences.applescript
--An InDesign AppleScript
--
--Sets the print preferences of the active document.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		make document
	end tell
end mySetup
on mySnippet()
	--Sets the print preferences of the active document.
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Print preferences.]
		--Given a document "myDocument"...
		--Get the bleed amounts from the document's bleed and add a bit.
		tell document preferences of myDocument
			set myX1Offset to document bleed inside or left offset + 3
			set myY1Offset to document bleed top offset + 3
			set myX2Offset to document bleed outside or right offset + 3
			set myY2Offset to document bleed bottom offset + 3
		end tell
		tell print preferences of myDocument
			--Properties corresponding to the controls in the General panel of the
			--Print dialog box. The active printer preset is ignored in this
			--example--we'll set our own print preferences.
			--printer can be either a string (the name of the printer) or
			--postscript file.
			set printer to postscript file
			--Here's an example of setting the printer to a specific printer.
			try
				--set printer to "AGFA-SelectSet 5000SF v2013.108"
			end try
			--If the printer property is the name of a printer, then the ppd
			--property is locked (and will return an error if you try to set it).
			try
				--set PPD to "AGFA SelectSet 7000-X"
			end try
			--If the printer property is set to postscript file, the copies
			--property is unavailable. Attempting to set it will generate an error.
			try
				set copies to 1
			end try
			--If the printer property is set to Printer.postscript file, or if the
			--selected printer does not support collation, then the collating
			--property is unavailable. Attempting to set it will generate an error.
			try
				set collating to false
			end try
			set reverse order to false
			--The setting of color output determines the settings available
			--to almost all other properties in the print preferences.
			try
				set color output to separations
			end try
			--pageRange can be either PageRange.allPages or a page range string.
			set page range to all pages
			set print spreads to false
			set print master pages to false
			--If the printer property is set to postScript file, then
			--the print file property contains the file path to the output file.
			--You'll have to fill in your own file path.
			set printFile to "yukino:test.ps"
			set sequence to all
			--If trapping is on, setting the following properties will produce an
			--error.
			try
				if trapping is off then
					set print blank pages to false
					set print guides grids to false
					set print nonprinting to false
				end if
			end try
			-------------------------------------------------------------------------
			--Properties corresponding to the controls in the Setup panel of the
			--Print dialog box.
			-------------------------------------------------------------------------
			try
				set paper size to custom
				set paper height to 1200
				set paper width to 1200
			end try
			try
				set print page orientation to portrait
			end try
			try
				set page position to centered
			end try
			try
				set paper gap to 0
			end try
			try
				set paper offset to 0
			end try
			try
				set paper transverse to false
			end try
			try
				set scale height to 100
				set scale width to 100
			end try
			try
				set scale mode to scale width height
			end try
			try
				set scale proportional to true
			end try
			--If trapping is on (application built in or Adobe inRip), attempting to
			--set the following properties will produce an error.
			try
				if trapping is off then
					set thumbnails to false
					--The following property is not needed because thumbnails is set
					--to false.
					--set thumbnails per page to 4
					set tile to false
					--The following properties are not needed because tile is set to
					--false.
					--set tiling overlap to 12
					--set tiling type to auto
				end if
			end try
			-------------------------------------------------------------------------
			--Properties corresponding to the controls in the Marks and Bleed panel
			--of the Print dialog box.
			-------------------------------------------------------------------------
			--Set the following property to true to print all printer's marks.
			--set all Printer Marks to true;
			set use document bleed to print to false
			--If use document bleed to print is true then setting any of the  bleed
			--properties will result in an error.
			set bleed bottom to myY2Offset
			set bleed top to myY1Offset
			set bleed inside to myX1Offset
			set bleed outside to myX2Offset
			if (myY2Offset + myY1Offset + myX1Offset + myX2Offset) is not equal to 0 then
				set bleed marks to true
			else
				set bleed marks to false
			end if
			set color bars to true
			set crop marks to true
			set include slug to print to false
			set mark line weight to p125pt
			set mark offset to 6
			--set mark Type to default
			set page information marks to true
			set registration marks to true
			-------------------------------------------------------------------------
			--Properties corresponding to the controls in the Output panel of the
			--Print dialog box.
			-------------------------------------------------------------------------
			try
				set negative to true
			end try
			try
				set color output to separations
			end try
			--Note the lowercase "i" in "Builtin"
			try
				set trapping to application builtin
			end try
			try
				set screening to "175 lpi/2400 dpi"
			end try
			try
				set flip to none
			end try
			--If trapping is on, attempting to set the following properties will
			--generate an error.
			try
				if trapping is off then
					set print black to true
					set print cyan to true
					set print magenta to true
					set print yellow to true
				end if
			end try
			--Only change the ink angle and frequency when you want to override the
			--screening set by the screening property.
			--set black angle to 45
			--set black frequency to 175
			--set cyan angle to 15
			--set cyan frequency to 175
			--set magenta angle to 75
			--set magenta frequency to 175
			--set yellow angle to 0
			--set yellow frequency to 175
			--The following properties are not needed (because colorOutput is set to
			--separations).
			--set composite angle to 45
			--set composite frequency to 175
			--set simulate overprint to false
			-------------------------------------------------------------------------
			--Properties corresponding to the controls in the Graphics panel of the
			--Print dialog box.
			-------------------------------------------------------------------------
			try
				set send image data to all image data
			end try
			set font downloading to complete
			try
				set download PPD fonts to true
			end try
			try
				set data format to binary
			end try
			try
				set PostScript level to level 3
			end try
			-------------------------------------------------------------------------
			--Properties corresponding to the controls in the Color Management panel
			--of the Print dialog box.
			-------------------------------------------------------------=-----------
			--If the use color management property of color settings is false,
			--attempting to set the following properties will return an error.
			try
				set source space to use document
				set intent to use color settings
				set CRD to use document
				set profile to PostScript CMS
			end try
			-------------------------------------------------------------------------
			--Properties corresponding to the controls in the Advanced panel of the
			--Print dialog box.
			-------------------------------------------------------------------------
			set OPI image replacement to false
			set omit bitmaps to false
			set omit EPS to false
			set omit PDF to false
			--The following line assumes that you have a flattener preset named
			--"high quality flattener".
			try
				set flattener preset name to "high quality flattener"
			end try
			set ignore spread overrides to false
		end tell
		--![Print preferences.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
