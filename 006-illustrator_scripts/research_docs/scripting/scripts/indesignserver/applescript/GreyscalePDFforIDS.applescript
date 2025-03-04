-- GreyscalePDFforIDS.applescript
-- An InDesign Server AppleScript
-- Shows how to export a gray scaled pdf
-- Create a new document
tell application "InDesignServer"
	set myDocument to make document
	--Get the bleed amounts from the document's bleed.
	tell document preferences of myDocument
		set pages per document to 2
		set facing pages to false
		set myPageWidth to page width
		set myPageHeight to page height
	end tell
	tell document preferences of document 1
		set myX1Offset to document bleed inside or left offset
		set myY1Offset to document bleed top offset
		set myX2Offset to document bleed outside or right offset
		set myY2Offset to document bleed bottom offset
	end tell
	--Get a reference to the first page
	set myPage to page 1 of myDocument
	tell myDocument
		--Create a text frame
		set myTextFrame to make text frame
		--Specify the size and shape of the text frame.
		set geometric bounds of myTextFrame to {"3p", "3p", "10p", "24p"}
		--Enter text in the text frame
		set contents of myTextFrame to "Hello, Adobe! "
		set myStory to story 1 of myDocument
		set myText to object reference of paragraph 1 of myStory
		--Set the text size
		set point size of myText to 30
		--Set the text color
		set fill color of myText to make color with properties {name:"DGC1_664a", model:process, color value:{100, 0, 0, 0}}
	end tell
	--Set watermark
	tell watermark preferences of myDocument
		set watermark visibility to true
		set watermark do print to true
		set watermark draw in back to true
		set watermark font color to green
		set watermark opacity to 80
		set watermark font point size to 100
		set watermark rotation to -45
		set watermark text to "Adobe"
		set watermark font style to "Bold"
		set watermark horizontal position to watermark h center
	end tell
     --Set export preference of PDF
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
		--color bitmap sampling dpi is not needed when color bitmap sampling is set to none.
		set grayscale bitmap compression to zip
		set grayscale bitmap quality to eight bit
		set grayscale bitmap sampling to none
		--threshold to compress gray is not needed in this example.
		--grayscale bitmap sampling dpi is not needed when grayscale bitmap sampling is set to none.
		set monochrome bitmap compression to zip
		set monochrome bitmap sampling to none
		--threshold to compress monochrome is not needed in this example.
		--monochrome bitmap sampling dpi is not needed when monochrome bitmap sampling is set to none.
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
		if bleed bottom is 0 and bleed top is 0 and bleed inside is 0 and bleed outside is 0 then
			set bleed marks to true
		else
			set bleed marks to false
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
		--Set PDF color space to gray for exporting
		set PDF color space to gray
		set PDF mark type to default
		set printer mark weight to p125pt
		set registration marks to true
		--simulate overprint is only available when the export standard is PDF/X-1a or PDF/X-3
		--set simulate overprint to false
		set use document bleed with PDF to true
		--Set viewPDF to true to open the PDF in Acrobat or Adobe Reader.
		set view PDF to false
	end tell
	--Now export and close the document.
	tell application "Finder"
		set myFile to (startup disk as string) & "ServerTestFiles:GreyscalePDFforIDS.pdf"
	end tell
	export document 1 format PDF type to myFile
	close document 1
end tell
