--XMLRuleExampleSetup.appleScript
--An InDesign AppleScript
--
--Sets up a document for the XML rules tutorial scripts.
main()
on main()
	tell application "Adobe InDesign 2024"
		set myFilePath to my myFindFile("XMLRulesExampleData.xml")
		set myDocument to make document
		tell myDocument
			tell XML import preferences
				set allow transform to false
				set ignore whitespace to true
			end tell
			import XML from myFilePath
			set myPage to page 1
			set myBounds to my myGetBounds(myDocument, myPage)
			tell XML item 1
				place into frame on myPage geometric bounds myBounds
			end tell
		end tell
	end tell
end main
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
on myFindFile(myFindFileName)
	tell application "Adobe InDesign 2024"
		try
			set myScript to active script
		on error
			set myScript to path to me
		end try
	end tell
	tell application "Finder"
		set myScript to file myScript
		set myParentFolder to (container of myScript) as string
		set myFileName to myParentFolder & myFindFileName
		set myResult to exists myFileName
		if myResult is true then
		else
			set myFileName to choose file with prompt "Locate your XML data file"
		end if
	end tell
	return myFileName
end myFindFile
