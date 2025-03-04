--AdjustPageItems.applescript
--An InDesign AppleScript
--
--Moves the content of even/odd pages by specified amounts; attempts to get
--objects back into the correct position after a master page margin change
--and/or page insertion.
--
--For more on InDesign/InCopy scripting see the documentation included in the Scripting SDK 
--available at http://www.adobe.com/devnet/indesign/sdk.html
--Or visit the InDesign Scripting User to User forum at http://www.adobeforums.com.
--
tell application "Adobe InDesign 2024"
	if (count documents) is not 0 then
		if (count page items of active document) is not 0 then
			my myDisplayDialog()
		end if
	end if
end tell
on myDisplayDialog()
	tell application "Adobe InDesign 2024"
		set myLabelWidth to 70
		set myPageNames to my myGetPageNames()
		set myDialog to make dialog with properties {name:"Adjust Page Items"}
		tell myDialog
			tell (make dialog column)
				tell (make border panel)
					tell (make dialog column)
						tell (make dialog row)
							tell (make dialog column)
								make static text with properties {static label:"Start Page:", min width:myLabelWidth}
							end tell
							tell (make dialog column)
								set myStartPageDropdown to make dropdown with properties {string list:myPageNames, selected index:0}
							end tell
						end tell
						tell (make dialog row)
							tell (make dialog column)
								make static text with properties {static label:"End Page:", min width:myLabelWidth}
							end tell
							tell (make dialog column)
								set myEndPageDropdown to make dropdown with properties {string list:myPageNames, selected index:(count myPageNames) - 1}
							end tell
						end tell
					end tell
				end tell
				tell (make border panel)
					tell (make dialog column)
						tell (make dialog row)
							tell (make dialog column)
								make static text with properties {static label:"Even Pages:", min width:myLabelWidth}
								make static text with properties {static label:"Horizontal:", min width:myLabelWidth}
								make static text with properties {static label:"Vertical:", min width:myLabelWidth}
							end tell
							tell (make dialog column)
								make static text with properties {static label:"", min width:myLabelWidth}
								set myEvenXField to make measurement editbox with properties {edit value:12, edit units:points}
								set myEvenYField to make measurement editbox with properties {edit value:0, edit units:points}
							end tell
						end tell
					end tell
				end tell
				tell (make border panel)
					tell (make dialog column)
						tell (make dialog row)
							tell (make dialog column)
								make static text with properties {static label:"Odd Pages:", min width:myLabelWidth}
								make static text with properties {static label:"Horizontal:", min width:myLabelWidth}
								make static text with properties {static label:"Vertical:", min width:myLabelWidth}
							end tell
							tell (make dialog column)
								make static text with properties {static label:"", min width:myLabelWidth}
								set myOddXField to make measurement editbox with properties {edit value:-12, edit units:points}
								set myOddYField to make measurement editbox with properties {edit value:0, edit units:points}
							end tell
						end tell
					end tell
				end tell
			end tell
		end tell
		set myResult to show myDialog
		if myResult is true then
			set myStartPageName to item ((selected index of myStartPageDropdown) + 1) of myPageNames
			set myEndPageName to item ((selected index of myEndPageDropdown) + 1) of myPageNames
			if my myCheckPageRange(myStartPageName, myEndPageName) is true then
				set myEvenX to edit value of myEvenXField
				set myEvenY to edit value of myEvenYField
				set myOddX to edit value of myOddXField
				set myOddY to edit value of myOddYField
				destroy myDialog
				my myAdjustPages(myStartPageName, myEndPageName, myEvenX, myEvenY, myOddX, myOddY)
			else
				destroy myDialog
				display dialog "Invalid page range."
			end if
		else
			destroy myDialog
		end if
	end tell
end myDisplayDialog
on myAdjustPages(myStartPageName, myEndPageName, myEvenX, myEvenY, myOddX, myOddY)
	tell application "Adobe InDesign 2024"
		--Set the measurement units to points.
		set myOldXUnits to horizontal measurement units of view preferences of active document
		set myOldYUnits to vertical measurement units of view preferences of active document
		set horizontal measurement units of view preferences of active document to points
		set vertical measurement units of view preferences of active document to points
		set myOldPageNumbering to page numbering of general preferences
		set page numbering of general preferences to section
		set myStartPage to document offset of page myStartPageName of active document
		set myEndPage to document offset of page myEndPageName of active document
		--Does the document start with an odd page or an even page?
		set myPageNumberStart to page number start of section 1 of active document
		repeat with myCounter from myStartPage to myEndPage
			--is it an even page or an odd page?
			set myPage to page myCounter of active document
			if ((document offset of myPage as number) + myPageNumberStart) mod 2 = 0 then
				--Page is an even page.
				my myAdjustPage(myPage, myEvenX, myEvenY)
			else
				--Page is an odd page.
				my myAdjustPage(myPage, myOddX, myOddY)
			end if
		end repeat
		--Reset the page numbering and measurement units to their original values.
		set horizontal measurement units of view preferences of active document to myOldXUnits
		set vertical measurement units of view preferences of active document to myOldYUnits
		set page numbering of general preferences to myOldPageNumbering
	end tell
end myAdjustPages
on myAdjustPage(myPage, myX, myY)
	tell application "Adobe InDesign 2024"
		set myResetItemLock to false
		set myResetLayerLock to false
		tell myPage
			repeat with myCounter from 1 to (count page items)
				set myPageItem to page item myCounter
				if locked of myPageItem is true then
					set locked of myPageItem to false
					set myResetItemLock to true
				end if
				if locked of item layer of myPageItem is true then
					set locked of item layer of myPageItem to false
					set myResetLayerLock to true
				end if
				move myPageItem by {myX, myY}
				if myResetItemLock is true then
					set locked of myPageItem to true
				end if
				if myResetLayerLock is true then
					set locked of item layer of myPageItem to true
				end if
			end repeat
		end tell
	end tell
end myAdjustPage
on myGetPageNames()
	tell application "Adobe InDesign 2024"
		set myPageNames to {}
		repeat with myCounter from 1 to (count pages of active document)
			copy name of page myCounter of active document to end of myPageNames
		end repeat
		return myPageNames
	end tell
end myGetPageNames
on myCheckPageRange(myStartPageName, myEndPageName)
	tell application "Adobe InDesign 2024"
		set myStartIndex to document offset of page myStartPageName of active document
		set myEndIndex to document offset of page myEndPageName of active document
		if myStartIndex <= myEndIndex then
			return true
		else
			return false
		end if
	end tell
end myCheckPageRange
