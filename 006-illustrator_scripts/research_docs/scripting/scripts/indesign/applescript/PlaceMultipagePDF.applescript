--PlaceMultipagePDF.applescript
--An InDesign AppleScript
--
--Places all of the pages in a PDF, creating a new page for each page.
--
--For more on InDesign/InCopy scripting see the documentation included in the Scripting SDK 
--available at http://www.adobe.com/devnet/indesign/sdk.html
--or visit the InDesign Scripting User to User forum at http://www.adobeforums.com.
--
set myPDF to choose file "Select a PDF file to place"
tell application "Adobe InDesign 2024"
	if (count documents) > 0 then
		set myDocument to active document
		set myStartPageName to my myDisplayDialog(myDocument)
		if myStartPageName is not equal to "" then
			set myStartPage to page myStartPageName of myDocument
		end if
	else
		set myDocument to make document
		set myStartPage to page 1 of myDocument
	end if
	my myPlacePDF(myDocument, myStartPage, myPDF)
end tell
on myDisplayDialog(myDocument)
	tell application "Adobe InDesign 2024"
		set myPageNames to my myGetPageNames(myDocument)
		set myLabelWidth to 70
		set myDialog to make dialog with properties {name:"Place PDF", can cancel:false}
		tell myDialog
			tell (make dialog column)
				tell (make dialog row)
					tell (make dialog column)
						make static text with properties {static label:"Start Page:", min width:myLabelWidth}
					end tell
					tell (make dialog column)
						set myStartPageDropdown to make dropdown with properties {string list:myPageNames, selected index:0}
					end tell
				end tell
			end tell
		end tell
		set myResult to show myDialog
		if myResult is true then
			set myStartPageName to item ((selected index of myStartPageDropdown) + 1) of myPageNames
			destroy myDialog
		else
			destroy myDialog
			set myStartPageName to ""
		end if
		return myStartPageName
	end tell
end myDisplayDialog
on myPlacePDF(myDocument, myPage, myPDF)
	tell application "Adobe InDesign 2024"
		set myDone to false
		set PDF crop of PDF place preferences to crop media
		set myCounter to 1
		repeat until myDone is true
			tell myDocument
				if myCounter > 1 then
					set myPage to make page at after myPage
				end if
			end tell
			set page number of PDF place preferences to myCounter
			get page number of PDF place preferences
			tell myPage
				set myPDFPage to place myPDF
				set myPDFPage to item 1 of myPDFPage
			end tell
			get properties of PDF attributes of myPDFPage
			if myCounter = 1 then
				set myFirstPage to page number of PDF attributes of myPDFPage
			else
				if page number of PDF attributes of myPDFPage = myFirstPage then
					tell myPage to delete
					set myDone to true
				end if
			end if
			set myCounter to myCounter + 1
		end repeat
	end tell
end myPlacePDF
on myGetPageNames(myDocument)
	tell application "Adobe InDesign 2024"
		set myPageNames to {}
		repeat with myCounter from 1 to (count pages of myDocument)
			copy name of page myCounter of myDocument to end of myPageNames
		end repeat
		return myPageNames
	end tell
end myGetPageNames
