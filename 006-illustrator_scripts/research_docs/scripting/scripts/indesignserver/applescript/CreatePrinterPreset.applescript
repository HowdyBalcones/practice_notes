--CreatePrinterPreset.js
--An InDesign Server AppleScript
--If the preset does not already exist, then create it of print preferences of myDocument
--otherwise, fill in the properties of the existing preset.
tell application "InDesignServer"
	try
		set myPreset to printer preset "myPreset"
	on error
		set myPreset to make printer preset with properties {name:"myPreset"}
	end try
	set myDocument to document 1
	tell myPreset
		--Because many printing properties are dependent on other printing properties,
		--we've surrounded each property-setting line with try...end try statements--
		--these will make it easier for you to experiment with print preset settings.
		try
			set printer to printer of print preferences of myDocument
		end try
		try
			set PPD to PPD of print preferences of myDocument
		end try
		try
			set copies to copies of print preferences of myDocument
		end try
		try
			set collating to collating of print preferences of myDocument
		end try
		try
			set reverse order to reverse order of print preferences of myDocument
		end try
		try
			set print spreads to print spreads of print preferences of myDocument
		end try
		try
			set print master pages to print master pages of print preferences of myDocument
		end try
		try
			set print file to printFile of print preferences of myDocument
		end try
		try
			set sequence to sequence of print preferences of myDocument
		end try
		try
			set print blank pages to print blank pages of print preferences of myDocument
		end try
		try
			set print guides grids to print guides grids of print preferences of myDocument
		end try
		try
			set print nonprinting to print nonprinting of print preferences of myDocument
		end try
		try
			set paper size to paper size of print preferences of myDocument
		end try
		try
			set paper height of myPreset to paper height of print preferences of myDocument
		end try
		try
			set paper width of myPreset to paper width of print preferences of myDocument
		end try
		try
			set print page orientation of myPreset to print page orientation of print preferences of myDocument
		end try
		try
			set page position of myPreset to page position of print preferences of myDocument
		end try
		try
			set paper gap of myPreset to paper gap of print preferences of myDocument
		end try
		try
			set paper offset of myPreset to paper offset of print preferences of myDocument
		end try
		try
			set paper transverse of myPreset to paper transverse of print preferences of myDocument
		end try
		try
			set scale height of myPreset to scale height of print preferences of myDocument
		end try
		try
			set scale width of myPreset to scale width of print preferences of myDocument
		end try
		try
			set scale mode of myPreset to scale mode of print preferences of myDocument
		end try
		try
			set scale proportional of myPreset to scale proportional of print preferences of myDocument
		end try
		try
			set text as black of myPreset to text as black of print preferences of myDocument
		end try
		try
			set thumbnails of myPreset to thumbnails of print preferences of myDocument
		end try
		try
			set thumbnails per page of myPreset to thumbnails per page of print preferences of myDocument
		end try
		try
			set tile of myPreset to tile of print preferences of myDocument
		end try
		try
			set tiling type of myPreset to tiling type of print preferences of myDocument
		end try
		try
			set tiling overlap of myPreset to tiling overlap of print preferences of myDocument
		end try
		try
			set all printer marks of myPreset to all printer marks of print preferences of myDocument
		end try
		try
			set use document bleed to print of myPreset to use document bleed to print of print preferences of myDocument
		end try
		try
			set bleed bottom of myPreset to bleed bottom of print preferences of myDocument
		end try
		try
			set bleed top of myPreset to bleed top of print preferences of myDocument
		end try
		try
			set bleed inside of myPreset to bleed inside of print preferences of myDocument
		end try
		try
			set bleed outside of myPreset to bleed outside of print preferences of myDocument
		end try
		try
			set bleed marks of myPreset to bleed marks of print preferences of myDocument
		end try
		try
			set color bars of myPreset to color bars of print preferences of myDocument
		end try
		try
			set crop marks of myPreset to crop marks of print preferences of myDocument
		end try
		try
			set include slug to print of myPreset to include slug to print of print preferences of myDocument
		end try
		try
			set mark line weight of myPreset to mark line weight of print preferences of myDocument
		end try
		try
			set mark offset of myPreset to mark offset of print preferences of myDocument
		end try
		try
			set mark type of myPreset to mark type of print preferences of myDocument
		end try
		try
			set page information marks of myPreset to page information marks of print preferences of myDocument
		end try
		try
			set registration marks of myPreset to registration marks of print preferences of myDocument
		end try
		try
			set negative of myPreset to negative of print preferences of myDocument
		end try
		try
			set color output of myPreset to color output of print preferences of myDocument
		end try
		try
			set trapping of myPreset to trapping of print preferences of myDocument
		end try
		try
			set screening of myPreset to screening of print preferences of myDocument
		end try
		try
			set flip of myPreset to flip of print preferences of myDocument
		end try
		try
			set print black of myPreset to print black of print preferences of myDocument
		end try
		try
			set print cyan of myPreset to print cyan of print preferences of myDocument
		end try
		try
			set print magenta of myPreset to print magenta of print preferences of myDocument
		end try
		try
			set print yellow of myPreset to print yellow of print preferences of myDocument
		end try
		try
			set black angle of myPreset to black angle of print preferences of myDocument
		end try
		try
			set black frequency of myPreset to black frequency of print preferences of myDocument
		end try
		try
			set cyan angle of myPreset to cyan angle of print preferences of myDocument
		end try
		try
			set cyan frequency of myPreset to cyan frequency of print preferences of myDocument
		end try
		try
			set magenta angle of myPreset to magenta angle of print preferences of myDocument
		end try
		try
			set magenta frequency of myPreset to magenta frequency of print preferences of myDocument
		end try
		try
			set yellow angle of myPreset to yellow angle of print preferences of myDocument
		end try
		try
			set yellow frequency of myPreset to yellow frequency of print preferences of myDocument
		end try
		try
			set composite angle of myPreset to composite angle of print preferences of myDocument
		end try
		try
			set composite frequency of myPreset to composite frequency of print preferences of myDocument
		end try
		try
			set simulate overprint of myPreset to simulate overprint of print preferences of myDocument
		end try
		try
			set send image data of myPreset to send image data of print preferences of myDocument
		end try
		try
			set font downloading of myPreset to font downloading of print preferences of myDocument
		end try
		try
			set download PPD fonts of myPreset to download PPD fonts of print preferences of myDocument
		end try
		try
			set data format of myPreset to data format of print preferences of myDocument
		end try
		try
			set PostScript level of myPreset to PostScript level of print preferences of myDocument
		end try
		try
			set source space of myPreset to source space of print preferences of myDocument
		end try
		try
			set intent of myPreset to intent of print preferences of myDocument
		end try
		try
			set CRD of myPreset to CRD of print preferences of myDocument
		end try
		try
			set profile of myPreset to profile of print preferences of myDocument
		end try
		try
			set OPI image replacement of myPreset to OPI image replacement of print preferences of myDocument
		end try
		try
			set omit bitmaps of myPreset to omit bitmaps of print preferences of myDocument
		end try
		try
			set omit EPS of myPreset to omit EPS of print preferences of myDocument
		end try
		try
			set omit PDF of myPreset to omit PDF of print preferences of myDocument
		end try
		try
			set flattener preset name of myPreset to flattener preset name of print preferences of myDocument
		end try
		try
			set ignore spread overrides of myPreset to ignore spread overrides of print preferences of myDocument
		end try
	end tell
end tell
