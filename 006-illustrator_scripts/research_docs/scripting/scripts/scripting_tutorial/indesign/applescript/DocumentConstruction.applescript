--DocumentConstruction.applescript
--An InDesign AppleScript
--
--From the "Adobe InDesign Scripting Tutorial"
--! [Measurements and ruler origin.]
tell application "Adobe InDesign 2024"
	--Create a new document.
	set myDocument to make document
	--Set the measurement units and ruler origin.
	set horizontal measurement units of view preferences to points
	set vertical measurement units of view preferences to points
	set ruler origin of view preferences to page origin
	--Get a reference to the first master spread.
	set myMasterSpread to master spread 1 of myDocument
	--Get a reference to the margin preferences of the first page in the master spread.
	tell margin preferences of page 1 of myMasterSpread
		--Now set up the page margins and columns.
		set left to 84
		set top to 70
		set right to 70
		set bottom to 78
		set column count to 3
		set column gutter to 14
	end tell
	--Page margins and columns for the right-hand page.
	tell margin preferences of page 2 of myMasterSpread
		set left to 84
		set top to 70
		set right to 70
		set bottom to 78
		set column count to 3
		set column gutter to 14
	end tell
	--! [Measurements and ruler origin.]
	--
	--! [Adding a baseline grid.]
	set myGridPreferences to grid preferences
	set baseline division of myGridPreferences to 14
	set baseline start of myGridPreferences to 70
	set baseline grid shown of myGridPreferences to true
	--! [Adding a baseline grid.]
	--
	--! [Adding master page items.]
	set myLeftPage to page 1 of myMasterSpread
	set myRightPage to page 2 of myMasterSpread
	tell myLeftPage
		set myLeftFooter to make text frame
		set geometric bounds of myLeftFooter to {728, 70, 742, 528}
		set first baseline offset of text frame preferences of myLeftFooter to leading offset
		set contents of myLeftFooter to auto page number
		set point size of character 1 of parent story of myLeftFooter to 11
		set leading of character 1 of myLeftFooter to 14
	end tell
	tell myRightPage
		set myRightFooter to make text frame
		set geometric bounds of myRightFooter to {728, 84, 742, 542}
		set first baseline offset of text frame preferences of myRightFooter to leading offset
		set contents of myRightFooter to auto page number
		set point size of character 1 of parent story of myRightFooter to 11
		set leading of character 1 of myRightFooter to 14
		set justification of character 1 of myRightFooter to right align
	end tell
	--! [Adding master page items.]
	--
	--! [Adding master text frames.]
	tell myLeftPage
		set myLeftTextFrame to make text frame
		set geometric bounds of myLeftTextFrame to {70, 70, 714, 528}
		set first baseline offset of text frame preferences of myLeftTextFrame to leading offset
		set text column count of text frame preferences of myLeftTextFrame to 3
		set text column gutter of text frame preferences of myLeftTextFrame to 14
		--Add a label to make the frame easier to find later on.
		set label of myLeftTextFrame to "BodyTextFrame"
	end tell
	tell myRightPage
		set myRightTextFrame to make text frame
		set geometric bounds of myRightTextFrame to {70, 84, 714, 542}
		set first baseline offset of text frame preferences of myRightTextFrame to leading offset
		set text column count of text frame preferences of myRightTextFrame to 3
		set text column gutter of text frame preferences of myRightTextFrame to 14
		--Add a label to make the frame easier to find later on.
		set label of myRightTextFrame to "BodyTextFrame"
	end tell
	--Link the two frames using the next text frame property.
	set next text frame of myLeftTextFrame to myRightTextFrame
	--! [Adding master text frames.]
	--
	--! [Overriding master page items and adding text.]
	tell text frame 1 of page 2 of master spread 1 of myDocument
		set myTextFrame to override destination page page 1 of myDocument
	end tell
	--Add text by setting the contents of an insertion point to a string.
	--In AppleScript, "return" is a return character.
	set contents of insertion point 1 of myTextFrame to "Headline!" & return
	--! [Overriding master page items and adding text.]
	--
	--! [Adding and applying a new paragraph style.]
	--First, check to see if the paragraph style already exists.
	try
		set myParagraphStyle to paragraph style "Heading 1" of myDocument
	on error
		--The paragraph style did not exist, so create it.
		tell myDocument
			set myParagraphStyle to make paragraph style with properties {name:"Heading 1"}
		end tell
	end try
	--We'll need to create a color. Check to see if the color already exists.
	try
		set myColor to color "Red" of myDocument
	on error
		--The color did not exist, so create it.
		tell myDocument
			set myColor to make color with properties {name:"Red", model:process, color value:{0, 100, 100, 0}}
		end tell
	end try
	--Now set the formatting of the paragraph style.
	try
		set applied font of myParagraphStyle to "Arial"
		set font style of myParagraphStyle to "Bold"
	end try
	set point size of myParagraphStyle to 24
	set space after of myParagraphStyle to 24
	set space before of myParagraphStyle to 24
	set fill color of myParagraphStyle to color "Red" of myDocument
	--Apply the style to the paragraph.
	tell paragraph 1 of myTextFrame to apply paragraph style using myParagraphStyle with clearing overrides
	--You could also use:
	--set applied paragarph style of paragraph 1 of myTextFrame to myParagraphStyle
	--! [Adding and applying a new paragraph style.]
	--
	--! [Place a text file.]
	--Display a standard open file dialog box to select a text file.
	set myTextFile to choose file ("Choose a text file")
	--If a text file was selected, and if you didn't press Cancel, 
	--place the text file at the first insertion point after the headline.
	if myTextFile is not "" then
		tell insertion point -1 of myTextFrame to place myTextFile
	end if
	--! [Place a text file.]
	--
	--! [Place a graphic file.]
	--Display a standard open file dialog box to select a graphic file.
	set myGraphicFile to choose file "Choose graphic file."
	--If a graphic file was selected, and if you didn't press Cancel, 
	--place the graphic file on the page.
	if myGraphicFile is not "" then
		set myGraphic to place myGraphicFile on page 1 of myDocument
		--Since you can place multiple graphics at once, the place method
		--returns an array. To get the graphic you placed, get the first
		--item in the array.
		set myGraphic to item 1 of myGraphic
		--Create an object style to apply to the graphic frame.
		try
			set myObjectStyle to object style "GraphicFrame" of myDocument
		on error
			--The object style did not exist, so create it.
			tell myDocument
				set myObjectStyle to make object style with properties {name:"GraphicFrame"}
			end tell
		end try
		set enable stroke of myObjectStyle to true
		set stroke weight of myObjectStyle to 3
		set stroke type of myObjectStyle to stroke style "Solid" of myDocument
		set stroke color of myObjectStyle to color "Red" of myDocument
		--The frame containing the graphic is the parent of the graphic.
		set myFrame to parent of myGraphic
		tell myFrame to apply object style using myObjectStyle
		--Resize the frame to a specific size.
		set geometric bounds of myFrame to {0, 0, 144, 144}
		--Fit the graphic to the frame proportionally.
		fit myFrame given proportionally
		--Next, fit frame to the resized graphic.
		fit myFrame given frame to content
		set myBounds to geometric bounds of myFrame
		set myGraphicWidth to (item 4 of myBounds) - (item 2 of myBounds)
		--Move the graphic frame.
		set myPageWidth to page width of document preferences of myDocument
		set myMarginPreferences to margin preferences of page 1 of myDocument
		set myTopMargin to top of myMarginPreferences
		move myFrame to {myPageWidth - myGraphicWidth, myTopMargin}
		--Apply a text wrap to the graphic frame.
		set text wrap mode of text wrap preferences of myFrame to bounding box text wrap
		set text wrap offset of text wrap preferences of myFrame to {24, 12, 24, 12}
	end if
end tell
--! [Place a graphic file.]
