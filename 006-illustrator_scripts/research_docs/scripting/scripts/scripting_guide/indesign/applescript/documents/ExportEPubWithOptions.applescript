--ExportEPubWithOptions.applescript
--An InDesign AppleScript
--
--Sets EPub export options, then exports the active document as EPub file.
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
		set myFile to myDesktopFolder & "ExportEPubWithOptions.indd"
		--Set the measurement units to points
		tell view preferences of myDocument
			set horizontal measurement units to points
			set vertical measurement units to points
			--Set the ruler origin to page origin.
			set ruler origin to page origin
		end tell
		
		set myPage to page 1 of myDocument
		tell myPage
			set myTextFrame to make text frame
			--Set the bounds of the text frame.
			set geometric bounds of myTextFrame to my myGetBounds(myDocument, myPage)
			--Enter text in the text frame.
			set contents of myTextFrame to "This is some example text."
		end tell
		tell myDocument
			set myDocument to save to myFile
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDesktopFolder to path to desktop as string
		set myFile to myDesktopFolder & "ExportEPubWithOptions.epub"
		set myDocument to document 1
		--![EPub export options.]
		tell myDocument
			tell EPub export preferences
				--Apply image alignment to anchored object settings.
				set apply image alignment to anchored object settings to false
				
				--Bottom margin of the epub.
				set bottom margin to 5
				--Left margin of the epub.
				set left margin to 5
				--Right margin of the epub.
				set right margin to 5
				--Top margin of the epub.
				set top margin to 5
				
				--If true, break InDesign document into smaller pieces when generating epub.
				set break document to true
				-- The name of paragraph style to break InDesign document.
				set paragraph style name to ""
				
				--The buttet export option.
				set bullet export option to as text
				
				set custom image size option to size relative to page width
				
				set embed font to true

				set epub cover to first page
				--This will take effect only when epub cover is set to external image.
				--set cover image file to "cover.jpg"
				
				set epub publisher to "Adobe Devtech"
				
				--The export order.
				set export order to layout order
				
				--If true, output footnote immediately after its paragraph.
				set footnote follow paragraph to false
				
				set GIF options interlaced to true
				set GIF options palette to windows palette
				
				--The epub unique identifier, like ISBN.
				set id to "123"
				
				--Ignore object level image conversion settings.
				set ignore object conversion settings to true
				
				--Alignment applied to images.
				set image alignment to align center
				--The file format to use for converted images.
				set image conversion to automatic
				set image export resolution to ppi 150
				--Image page break settings to be used with objects.
				set image page break to page break after
				--Space After applied to images.
				set image space after to 2
				--Space Before applied to images.
				set image space before to 2
				
				--If true, output document metadata into epub.
				set include document metadata to true
				
				set JPEG options format to baseline encoding
				set JPEG options quality to high
				
				--The PNG compression level.
				set level to 5
				
				set numbered list export option to as text
				
				--If true, format image based on layout appearence.
				set preserve layout appearence to true
				--If true, output local style override.
				set preserve local override to true
				
				set strip soft return to true
				--If true, image page break settings will be used in objects.
				set use image page break to true
				--Use a defined TOC style to generate epub TOC.
				--set use toc style name to "MyTOCStyle"
				
				set view document after export to false
			end tell
			
			export format EPUB to myFile without showing options
		end tell
		--![EPub export options.]
	end tell
end mySnippet
on myTeardown()
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
