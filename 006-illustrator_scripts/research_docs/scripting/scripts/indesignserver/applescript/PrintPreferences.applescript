--PrintPreferences.applescript
--An InDesign Server AppleScript
--Sets the print preferences of the current document.
tell application "InDesignServer"
	if (count documents) is not equal to 0 then
		--Get the bleed amounts from the document's bleed and add a bit.
		tell document preferences of document 1
			set myX1Offset to document bleed inside or left offset + 3
			set myY1Offset to document bleed top offset + 3
			set myX2Offset to document bleed outside or right offset + 3
			set myY2Offset to document bleed bottom offset + 3
		end tell
		tell print preferences of document 1
			--Properties corresponding to the controls in the General panel of the Print dialog box.
			--active printer preset is ignored in this example--we'll set our own print preferences.
			--printer can be either a string (the name of the printer) or
			--postscript file.
			set printer to postscript file
			--Here's an example of setting the printer to a specific printer.
			--set printer to "AGFA-SelectSet 5000SF v2013.108"
			--If the printer property is the name of a printer, then the ppd property
			--is locked (and will return an error if you try to set it).
			try
				set PPD to "AGFA-SelectSet 5000SF v2013.108"
			end try
			--If the printer property is set to postscript file, the copies
			--property is unavailable. Attempting to set it will generate an error.
			--set copies to 1
			--If the printer property is set to Printer.postscript file, or if the
			--selected printer does not support collation, then the collating 
			--property is unavailable. Attempting to set it will generate an error.
			--set collating to false
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
			--set printFile to "yukino:test.ps"
			set sequence to all
			--If trapping is on, setting the following properties will produce an error.
			try
				if trapping is off then
					set print blank pages to false
					set print guides grids to false
					set print nonprinting to false
				end if
			end try
			----------------------------------------------------------------------------------
			--Properties corresponding to the controls in the Setup panel of the Print dialog box.
			----------------------------------------------------------------------------------
			set paper size to custom
			--Page width and height are ignored if paper Size is not custom.
			--set paper height to 1200
			--set paper width to 1200
			set print page orientation to portrait
			set page position to centered
			set paper gap to 0
			set paper offset to 0
			set paper transverse to false
			set scale height to 100
			set scale width to 100
			set scale mode to scale width height
			set scale proportional to true
			--If trapping is on (application built in or Adobe inRip), attempting to set the following properties will produce an error.
			if trapping is off then
				try
					set thumbnails to false
					
					--The following properties is not needed because thumbnails is set to false.
					--set thumbnails per page to 4
					set tile to false
					--The following properties are not needed because tile is set to false.
					--set tiling overlap to 12
					--set tiling type to auto
				end try
			end if
			----------------------------------------------------------------------------------
			--Properties corresponding to the controls in the Marks and Bleed panel of the Print dialog box.
			----------------------------------------------------------------------------------
			--Set the following property to true to print all printer's marks.
			--set all Printer Marks to true;
			set use document bleed to print to false
			--If use document bleed to print is true then setting any of the  bleed properties
			--will result in an error.
			set bleed bottom to myY2Offset
			set bleed top to myY1Offset
			set bleed inside to myX1Offset
			set bleed outside to myX2Offset
			--If any bleed area is greater than zero, then export the bleed marks.
			if bleed bottom is equal to 0 and bleed top is equal to 0 and bleed inside is equal to 0 and bleed outside is equal to 0 then
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
			----------------------------------------------------------------------------------
			--Properties corresponding to the controls in the Output panel of the Print dialog box.
			----------------------------------------------------------------------------------
			set color output to separations
			set negative to true
			--Note the lowercase "i" in "Builtin"
			set trapping to application builtin
			set screening to "175 lpi/2400 dpi"
			set flip to none
			--If trapping is on, attempting to set the following properties will generate an error.
			if trapping is off then
				set print black to true
				set print cyan to true
				set print magenta to true
				set print yellow to true
			end if
			--Only change the ink angle and frequency when you want to override the
			--screening set by the screening specified by the screening property.
			--set black angle to 45
			--set black frequency to 175
			--set cyan angle to 15
			--set cyan frequency to 175
			--set magenta angle to 75
			--set magenta frequency to 175
			--set yellow angle to 0
			--set yellow frequency to 175
			--The following properties are not needed (because colorOutput is set to separations).
			--set composite angle to 45
			--set composite frequency to 175
			--set simulate overprint to false
			----------------------------------------------------------------------------------
			--Properties corresponding to the controls in the Graphics panel of the Print dialog box.
			----------------------------------------------------------------------------------
			set send image data to all image data
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
			----------------------------------------------------------------------------------
			--Properties corresponding to the controls in the Color Management panel of the Print dialog box.
			----------------------------------------------------------------------------------
			--If the use color management property of color settings is false,
			--attempting to set the following properties will return an error.
			try
				set source space to use document
				set intent to use color settings
				set CRD to use document
				set profile to PostScript CMS
			end try
			----------------------------------------------------------------------------------
			--Properties corresponding to the controls in the Advanced panel of the Print dialog box.
			----------------------------------------------------------------------------------
			set OPI image replacement to false
			set omit bitmaps to false
			set omit EPS to false
			set omit PDF to false
			--The following line assumes that you have a flattener preset named "high quality flattener".
			try
				set flattener preset name to "high quality flattener"
			end try
			set ignore spread overrides to false
		end tell
	else
		set result to "No documents are open."
	end if
end tell
