--ImageCatalog.applescript
--An InDesign AppleScript
--
--Creates an image catalog from the graphics files in a selected folder.
--
--For more on InDesign/InCopy scripting see the documentation included in the Scripting SDK 
--available at http://www.adobe.com/devnet/indesign/sdk.html
--or visit the InDesign Scripting forum at http://www.adobeforums.com
--
set myExtensions to {".tif", ".tiff", ".jpg", ".jpeg", ".gif", ".eps", ".ps", ".psd", ".ai"}
set myFileList to {}
set myFolder to choose folder with prompt "Select the folder containing the graphics you want to place"
tell application "Finder"
	set myFiles to every file of folder myFolder
end tell
--Build a list of graphics files in the folder.
repeat with myCounter from 1 to count of items in myFiles
	set myFile to item myCounter of myFiles
	set myFileType to file type of myFile
	set theName to the name of myFile
	if myFileType is "JPEG" then
		copy myFile to end of myFileList
	end if
	if myFileType is "EPSF" then
		copy myFile to end of myFileList
	end if
	if myFileType is "PICT" then
		copy myFile to end of myFileList
	end if
	if myFileType is "TIFF" then
		copy myFile to end of myFileList
	end if
	if myFileType is "8BPs" then
		copy myFile to end of myFileList
	end if
	if myFileType is "GIFf" then
		copy myFile to end of myFileList
	end if
	if myFileType is "PDF " then
		copy myFile to end of myFileList
	end if
	if myFileType is missing value or myFileType is "TEXT" then
		repeat with myExtension in myExtensions
			if theName ends with myExtension then
				copy myFile to end of myFileList
				exit repeat
			end if
		end repeat
	end if
end repeat
if (count myFileList) > 0 then
	myDisplayDialog(myFileList, myFolder)
end if
--show the dialog
on myDisplayDialog(myFiles, myFolder)
	set myLabelWidth to 132
	tell application "Adobe InDesign 2024"
		set myStyleNames to my myGetStyleNames()
		set myLayerNames to {"Layer 1", "Labels"}
		set myLabelTypes to {"File Name", "File Path", "XMP Description", "XMP Author"}
		set myDialog to make dialog with properties {name:"ImageCatalog"}
		tell myDialog
			tell (make dialog column)
				tell (make dialog row)
					make static text with properties {static label:"Information"}
				end tell
				tell (make border panel)
					tell (make dialog column)
						tell (make dialog row)
							--staticTexts.add({staticLabel:"Source Folder:", minWidth:myLabelWidth}); 
							make static text with properties {static label:"SourceFolder:", min width:myLabelWidth}
							--staticTexts.add({staticLabel:myFolder.path + "/" + myFolder.name}); 
							make static text with properties {static label:myFolder, min width:myLabelWidth}
						end tell
						tell (make dialog row)
							--staticTexts.add({staticLabel:"Number of Images:", minWidth:myLabelWidth}); 
							make static text with properties {static label:"Number of Graphics:", min width:myLabelWidth}
							--staticTexts.add({staticLabel:myFiles.length + ""}); 
							make static text with properties {static label:((count myFiles) as string)}
						end tell
					end tell
				end tell
				tell (make dialog row)
					make static text with properties {static label:"Options"}
				end tell
				tell (make border panel)
					tell (make dialog column)
						tell (make dialog row)
							make static text with properties {static label:"Number of Rows:", min width:myLabelWidth}
							set myNumberOfRowsField to make integer editbox with properties {edit value:3}
						end tell
						tell (make dialog row)
							make static text with properties {static label:"Number of Columns:", min width:myLabelWidth}
							set myNumberOfColumnsField to make integer editbox with properties {edit value:3}
						end tell
						tell (make dialog row)
							make static text with properties {static label:"Vertical Offset:", min width:myLabelWidth}
							set myVerticalOffsetField to make measurement editbox with properties {edit value:12, edit units:points}
						end tell
						tell (make dialog row)
							make static text with properties {static label:"Horizontal Offset:", min width:myLabelWidth}
							set myHorizontalOffsetField to make measurement editbox with properties {edit value:12, edit units:points}
						end tell
						tell (make dialog row)
							tell (make dialog column)
								make static text with properties {static label:"Fitting:", min width:myLabelWidth}
							end tell
							tell (make dialog column)
								set myFitProportionalCheckbox to make checkbox control with properties {static label:"Proportional", checked state:true}
								set myFitCenterContentCheckbox to make checkbox control with properties {static label:"Center Content", checked state:true}
								set myFitFrameToContentCheckbox to make checkbox control with properties {static label:"FrameToContent", checked state:true}
							end tell
						end tell
						tell (make dialog row)
							set myRemoveEmptyFramesCheckbox to make checkbox control with properties {static label:"Remove Empty Frames", checked state:true}
						end tell
					end tell
				end tell
				--"Spacer" to prevent labels group from obscuring the bottom of the above border panel.
				make static text with properties {static label:""}
				set myLabelsGroup to make enabling group with properties {static label:"Labels", checked state:true}
				tell myLabelsGroup
					tell (make dialog column)
						tell (make dialog row)
							tell (make dialog column)
								make static text with properties {static label:"Label Type:", min width:myLabelWidth}
							end tell
							tell (make dialog column)
								set myLabelTypeDropdown to make dropdown with properties {string list:myLabelTypes, selected index:0}
							end tell
						end tell
						tell (make dialog row)
							tell (make dialog column)
								make static text with properties {static label:"Label Height:", min width:myLabelWidth}
							end tell
							tell (make dialog column)
								set myLabelHeightField to make measurement editbox with properties {edit value:24, edit units:points}
							end tell
						end tell
						tell (make dialog row)
							tell (make dialog column)
								make static text with properties {static label:"Label Offset:", min width:myLabelWidth}
							end tell
							tell (make dialog column)
								set myLabelOffsetField to make measurement editbox with properties {edit value:0, edit units:points}
							end tell
						end tell
						tell (make dialog row)
							tell (make dialog column)
								make static text with properties {static label:"Label Style:", min width:myLabelWidth}
							end tell
							tell (make dialog column)
								set myLabelStyleDropdown to make dropdown with properties {string list:myStyleNames, selected index:0}
							end tell
						end tell
						tell (make dialog row)
							tell (make dialog column)
								make static text with properties {static label:"Label Layer:", min width:myLabelWidth}
							end tell
							tell (make dialog column)
								set myLabelLayerDropdown to make dropdown with properties {string list:myLayerNames, selected index:0}
							end tell
						end tell
					end tell
				end tell
			end tell
		end tell
		set myResult to show myDialog
		if myResult = true then
			set myNumberOfRows to edit value of myNumberOfRowsField
			set myNumberOfColumns to edit value of myNumberOfColumnsField
			set myVerticalOffset to edit value of myVerticalOffsetField
			set myHorizontalOffset to edit value of myHorizontalOffsetField
			set myFitProportional to checked state of myFitProportionalCheckbox
			set myFitCenterContent to checked state of myFitCenterContentCheckbox
			set myFitFrameToContent to checked state of myFitFrameToContentCheckbox
			set myRemoveEmptyFrames to checked state of myRemoveEmptyFramesCheckbox
			--Label settings
			if checked state of myLabelsGroup is true then
				set myMakeLabels to true
			else
				set myMakeLabels to false
			end if
			set myLabelType to item ((selected index of myLabelTypeDropdown) + 1) of myLabelTypes
			set myLabelStyleName to item ((selected index of myLabelStyleDropdown) + 1) of myStyleNames
			set myLabelLayerName to item ((selected index of myLabelLayerDropdown) + 1) of myLayerNames
			set myLabelHeight to edit value of myLabelHeightField
			set myLabelOffset to edit value of myLabelOffsetField
			my myMakeImageCatalog(myFiles, myNumberOfRows, myNumberOfColumns, myRemoveEmptyFrames, myVerticalOffset, myHorizontalOffset, myFitProportional, myFitCenterContent, myFitFrameToContent, myMakeLabels, myLabelType, myLabelStyleName, myLabelLayerName, myLabelHeight, myLabelOffset)
			display dialog "Done!"
		end if
		destroy myDialog
	end tell
end myDisplayDialog

on myMakeImageCatalog(myFiles, myNumberOfRows, myNumberOfColumns, myRemoveEmptyFrames, myVerticalOffset, myHorizontalOffset, myFitProportional, myFitCenterContent, myFitFrameToContent, myMakeLabels, myLabelType, myLabelStyleName, myLabelLayerName, myLabelHeight, myLabelOffset)
	tell application "Adobe InDesign 2024"
		--var myFramesPerPage = myNumberOfRows * myNumberOfColumns;  
		set myFramesPerPage to myNumberOfRows * myNumberOfColumns
		--var myDocument = app.documents.add(); 
		set myDocument to make document
		--myDocument.viewPreferences.horizontalMeasurementUnits = MeasurementUnits.points; 
		set horizontal measurement units of view preferences of myDocument to points
		--myDocument.viewPreferences.verticalMeasurementUnits = MeasurementUnits.points; 
		set vertical measurement units of view preferences of myDocument to points
		--var myDocumentPreferences = myDocument.documentPreferences;  
		set myDocumentPreferences to document preferences of myDocument
		--var myNumberOfFrames = myFiles.length; 
		set myNumberOfFrames to (count myFiles)
		--var myNumberOfPages = Math.round(myNumberOfFrames / myFramesPerPage); 
		set myNumberOfPages to text item 1 of ((myNumberOfFrames / myFramesPerPage) as string)
		if ((myNumberOfPages * myFramesPerPage) < myNumberOfFrames) then
			set myNumberOfPages to myNumberOfPages + 1
		end if
		set pages per document of myDocumentPreferences to (myNumberOfPages as integer)
		set facing pages of myDocumentPreferences to false
		set myPage to page 1 of myDocument
		set myMarginPreferences to margin preferences of myPage
		set myLeftMargin to left of myMarginPreferences
		set myTopMargin to top of myMarginPreferences
		set myRightMargin to right of myMarginPreferences
		set myBottomMargin to bottom of myMarginPreferences
		set myLiveWidth to ((page width of myDocumentPreferences) - (myLeftMargin + myRightMargin)) + myHorizontalOffset
		set myLiveHeight to (page height of myDocumentPreferences) - (myTopMargin + myBottomMargin)
		set myColumnWidth to myLiveWidth / myNumberOfColumns
		set myFrameWidth to myColumnWidth - myHorizontalOffset
		set myRowHeight to (myLiveHeight / myNumberOfRows)
		set myFrameHeight to myRowHeight - myVerticalOffset
		if myLabelType is not equal to 0 then
			try
				set myLabelStyle to paragraph style myLabelStyleName of myDocument
			on error
				tell myDocument
					set myLabelStyle to make paragraph style with properties {name:myLabelStyleName}
				end tell
			end try
			try
				set myLabelLayer to layer myLabelLayerName of myDocument
			on error
				tell myDocument
					set myLabelLayer to make layer with properties {name:myLabelLayerName}
				end tell
			end try
		end if
		--Construct the frames in reverse order. Don't laugh--this will  
		--save us time later (when we place the graphics).  
		--for (myCounter = myDocument.pages.length-1; myCounter >= 0; myCounter--){  
		repeat with myCounter from (count pages of myDocument) to 1 by -1
			--myPage = myPages.item(myCounter) ; 
			set myPage to page myCounter of myDocument
			--for (var myRowCounter = myNumberOfRows; myRowCounter >= 1; myRowCounter--){  
			repeat with myRowCounter from (myNumberOfRows - 1) to 0 by -1
				set myY1 to myTopMargin + (myRowHeight * myRowCounter)
				set myY2 to myY1 + myFrameHeight
				--for (var myColumnCounter = myNumberOfColumns; myColumnCounter >= 1; myColumnCounter--){  
				repeat with myColumnCounter from (myNumberOfColumns - 1) to 0 by -1
					set myX1 to myLeftMargin + (myColumnWidth * myColumnCounter)
					set myX2 to myX1 + myFrameWidth
					tell myPage to make rectangle with properties {geometric bounds:{myY1, myX1, myY2, myX2}, stroke weight:0, stroke color:swatch "None" of myDocument, item layer:layer -1 of myDocument}
				end repeat
			end repeat
		end repeat
		--Because we constructed the frames in reverse order, rectangle 1  
		--is the first rectangle on page 1, so we can simply iterate through  
		--the rectangles, placing a file in each one in turn. myFiles = myFolder.Files;  
		--for (myCounter = 0; myCounter < myNumberOfFrames; myCounter++){  
		repeat with myCounter from 1 to myNumberOfFrames
			set myFile to item myCounter of myFiles
			set myRectangle to rectangle myCounter of myDocument
			tell myRectangle
				set myGraphic to place (myFile as string)
				--The place command returns a list, so get the
				--first item of the list.
				set myGraphic to item 1 of myGraphic
				set label to myFile as string
				if myFitProportional is true then
					fit given proportionally
				end if
				if myFitCenterContent is true then
					fit given center content
				end if
				if myFitFrameToContent is true then
					fit given frame to content
				end if
			end tell
			if myMakeLabels is true then
				set myLink to item link of myGraphic
				if myLabelType is "File Name" then
					set myLabelString to name of myLink
				else if myLabelType is "File Path" then
					set myLabelString to file path of myLink
				else if myLabelType is "XMP Description" then
					--Get the XMP description data from the graphic.
					try
						set myLabelString to description of link xmp of myLink
					on error
						set myLabelString to "No description available."
					end try
				else if myLabelType is "XMP Author" then
					--Get the XMP author data from the graphic.
					try
						set myLabelString to author of link xmp of myLink
					on error
						set myLabelString to "No author available."
					end try
				end if
				set myX1 to item 2 of geometric bounds of myRectangle
				--myY1 = myRectangle.geometricBounds[2]; 
				set myBounds to geometric bounds of myRectangle
				set myY1 to item 3 of myBounds
				set myY1 to myY1 + myLabelOffset
				set myX2 to item 4 of myBounds
				set myY2 to myY1 + myLabelHeight
				tell parent of myRectangle
					set myTextFrame to make text frame with properties {geometric bounds:{myY1, myX1, myY2, myX2}, contents:myLabelString, item layer:myLabelLayer}
					tell myTextFrame
						set first baseline offset of text frame preferences to leading offset
						set applied paragraph style of text 1 to myLabelStyle
					end tell
				end tell
			end if
		end repeat
		--Remove any empty frames.
		if myRemoveEmptyFrames is true then
			tell myDocument
				tell (every rectangle whose content type is unassigned) to delete
			end tell
		end if
	end tell
end myMakeImageCatalog
--Get application default paragraph styles.
on myGetStyleNames()
	tell application "Adobe InDesign 2024"
		set myStyleNames to name of every paragraph style
		if "Labels" is not in myStyleNames then
			copy "Labels" to end of myStyleNames
		end if
		return myStyleNames
	end tell
end myGetStyleNames
