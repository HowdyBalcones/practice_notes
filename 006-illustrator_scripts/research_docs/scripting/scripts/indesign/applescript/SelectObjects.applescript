--SelectObjects.applescript
--An InDesign AppleScript
--
--This script selects all objects of a given type or types on the active spread.
--When you choose one of the imported graphic types, the script will select
--the frame containing the graphic (and not the graphic itself).
--
--For more on InDesign/InCopy scripting see the documentation included in the Scripting SDK 
--available at http://www.adobe.com/devnet/indesign/sdk.html
--or visit the InDesign Scripting User to User forum at http://www.adobeforums.com.
--
tell application "Adobe InDesign 2024"
	if (count documents) > 0 then
		my myDisplayDialog()
	else
		display dialog "Please open a document, select a page item, and try again."
	end if
end tell
on myDisplayDialog()
	--Create the SelectObjects dialog box.
	tell application "Adobe InDesign 2024"
		set myDialog to make dialog with properties {name:"SelectObjects"}
		tell myDialog
			tell (make dialog column)
				tell (make border panel)
					make static text with properties {static label:"Select:"}
					tell (make dialog column)
						set myRectanglesCheckbox to make checkbox control with properties {static label:"Rectangles", checked state:true}
						set myEllipsesCheckbox to make checkbox control with properties {static label:"Ellipses", checked state:true}
						set myPolygonsCheckbox to make checkbox control with properties {static label:"Polygons", checked state:true}
						set myGraphicLinesCheckbox to make checkbox control with properties {static label:"Graphic Lines", checked state:true}
						set myTextFramesCheckbox to make checkbox control with properties {static label:"Text Frames", checked state:true}
						set myGroupsCheckbox to make checkbox control with properties {static label:"Groups", checked state:true}
						set myImagesCheckbox to make checkbox control with properties {static label:"Images", checked state:true}
						set myPDFsCheckbox to make checkbox control with properties {static label:"PDFs", checked state:true}
						set myEPSsCheckbox to make checkbox control with properties {static label:"EPSs", checked state:true}
					end tell
				end tell
			end tell
		end tell
		set myResult to show myDialog
		if myResult is true then
			set myObjectTypes to {}
			--Gather control settings from the dialog box and build
			--an array containing the object types to select.
			if checked state of myRectanglesCheckbox is true then
				copy "rectangles" to end of myObjectTypes
			end if
			if checked state of myEllipsesCheckbox is true then
				copy "ovals" to end of myObjectTypes
			end if
			if checked state of myPolygonsCheckbox is true then
				copy "polygons" to end of myObjectTypes
			end if
			if checked state of myGraphicLinesCheckbox is true then
				copy "graphic lines" to end of myObjectTypes
			end if
			if checked state of myTextFramesCheckbox is true then
				copy "text frames" to end of myObjectTypes
			end if
			if checked state of myGroupsCheckbox is true then
				copy "groups" to end of myObjectTypes
			end if
			if checked state of myImagesCheckbox is true then
				copy "images" to end of myObjectTypes
			end if
			if checked state of myPDFsCheckbox is true then
				copy "epss" to end of myObjectTypes
			end if
			if checked state of myEPSsCheckbox is true then
				copy "pdfs" to end of myObjectTypes
			end if
			--Remove the dialog from memory.
			destroy myDialog
			my mySelectObjects(myObjectTypes)
		else
			--Remove the dialog from memory.
			destroy myDialog
		end if
	end tell
end myDisplayDialog
on mySelectObjects(myObjectTypes)
	tell application "Adobe InDesign 2024"
		set myObjectsToSelect to {}
		tell active spread of active window
			repeat with myCounter from 1 to (count myObjectTypes)
				set myPageItems to {}
				if ((item myCounter of myObjectTypes is not equal to "images") and Â
					(item myCounter of myObjectTypes is not equal to "epss") and Â
					(item myCounter of myObjectTypes is not equal to "pdfs")) then
					set myString to "tell application \"Adobe InDesign 2024\"" & return
					set myString to myString & "tell active spread of active window" & return
					set myString to myString & "get " & item myCounter of myObjectTypes & return
					set myString to myString & "end tell" & return
					set myString to myString & "end tell"
					set myPageItems to run script myString
					if (count myPageItems) > 0 then
						repeat with myPageItemCounter from 1 to (count myPageItems)
							copy item myPageItemCounter of myPageItems to end of myObjectsToSelect
						end repeat
					end if
				end if
			end repeat
			repeat with myCounter from 1 to count page items
				set myPageItem to page item myCounter
				if class of myPageItem is not graphic line and class of myPageItem is not text frame then
					if (count graphic of myPageItem) > 0 then
						if ((myObjectTypes contains "images") and {class of graphic 1 of myPageItem = image} or Â
							(myObjectTypes contains "epss") and {class of graphic 1 of myPageItem = EPS} or Â
							(myObjectTypes contains "pdfs") and {class of graphic 1 of myPageItem = PDF}) then
							--It's OK for the object to appear in the selection list multiple times.
							copy myPageItem to end of myObjectsToSelect
						end if
					end if
				end if
			end repeat
		end tell
		select myObjectsToSelect
	end tell
end mySelectObjects
