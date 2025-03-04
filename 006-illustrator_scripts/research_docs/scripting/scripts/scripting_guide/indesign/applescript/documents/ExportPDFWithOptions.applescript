--ExportPDFWithOptions.applescript
--An InDesign AppleScript
--
--Sets PDF export preferences and exports the document.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		set myDesktopFolder to path to desktop as string
		set myFile to myDesktopFolder & "ExportPDFWithOptions.indd"
		tell myDocument
			set pages per document of document preferences to 6
			set facing pages of document preferences to false
			set myPageHeight to page height of document preferences
			set myPageWidth to page width of document preferences
			--Create a single-page master spread.
			tell master spread 1
				repeat while (count of pages) > 1
					delete page -1
				end repeat
				tell page 1
					set myTextFrame to make text frame with properties {geometric bounds:{0, 0, myPageHeight, myPageWidth}, contents:auto page number}
				end tell
				set vertical justification of text frame preferences of myTextFrame to center align
				set justification of paragraph 1 of myTextFrame to center align
				set point size of character 1 of myTextFrame to 72
			end tell
			set myDocument to save to myFile
		end tell
	end tell
end mySetup
on mySnippet()
	--Sets PDF export preferences.
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Export PDF with options.]
		--Get the bleed amounts from the document's bleed.
		tell document preferences of myDocument
			set myX1Offset to document bleed inside or left offset
			set myY1Offset to document bleed top offset
			set myX2Offset to document bleed outside or right offset
			set myY2Offset to document bleed bottom offset
		end tell
		tell PDF export preferences
			--Basic PDF output options.
			set page range to all pages
			set acrobat compatibility to acrobat 6
			set export guides and grids to false
			set export layers to false
			set export nonprinting objects to false
			set export reader spreads to false
			set generate thumbnails to false
			try
				set ignore spread overrides to false
			end try
			set include bookmarks to true
			set include hyperlinks to true
			try
				set include ICC profiles to true
			end try
			set include slug with PDF to false
			set include structure to false
			set interactive elements option to do not include
			--Setting subset fonts below to zero disallows font subsetting
			--set subset fonts below to some other value to use font subsetting.
			set subset fonts below to 0
			--Bitmap compression/sampling/quality options.
			set color bitmap compression to zip
			set color bitmap quality to eight bit
			set color bitmap sampling to none
			--threshold to compress color is not needed in this example.
			--color bitmap sampling dpi is not needed when color bitmap sampling is
			--set to none.
			set grayscale bitmap compression to zip
			set grayscale bitmap quality to eight bit
			set grayscale bitmap sampling to none
			--threshold to compress gray is not needed in this example.
			--grayscale bitmap sampling dpi is not needed when grayscale bitmap
			--sampling is set to none.
			set monochrome bitmap compression to zip
			set monochrome bitmap sampling to none
			--threshold to compress monochrome is not needed in this example.
			--monochrome bitmap sampling dpi is not needed when monochrome bitmap
			--sampling is set to none.
			--Other compression options.
			set compression type to Compress None
			set compress text and line art to true
			set crop images to frames to true
			set optimize PDF to true
			--Printers marks and prepress options.
			set bleed bottom to myY2Offset
			set bleed top to myY1Offset
			set bleed inside to myX1Offset
			set bleed outside to myX2Offset
			--If any bleed area is greater than zero, then export the bleed marks.
			set b1 to bleed bottom is equal to 0
			set b2 to bleed top is equal to 0
			set b3 to bleed inside is equal to 0
			set b4 to bleed outside is equal to 0
			if b1 and b2 and b3 and b4 then
				set bleed marks to false
			else
				set bleed marks to true
			end if
			set color bars to true
			--Color tile size and gray tile size are not used
			--unless the compression method chosen is JPEG 2000.
			--set color tile size to 256
			--set Gray tile size to 256
			set crop marks to true
			set omit bitmaps to false
			set omit EPS to false
			set omit PDF to false
			set page information marks to true
			set page marks offset to "12 pt"
			set PDF color space to unchanged color space
			set PDF mark type to default
			set printer mark weight to p125pt
			set registration marks to true
			--simulate overprint is only available when the export standard is
			--PDF/X-1a or PDF/X-3
			--set simulate overprint to false
			set use document bleed with PDF to true
			--Set viewPDF to true to open the PDF in Acrobat or Adobe Reader.
			set view PDF to false
		end tell
		--Now export the document to the desktop.
		set myDesktopFolder to path to desktop as string
		set myFile to myDesktopFolder & "ExportPDFWithOptions.pdf"
		tell myDocument
			export format PDF type to myFile without showing options
		end tell
	end tell
	--![Export PDF with options.]
end mySnippet
on myTeardown()
end myTeardown
