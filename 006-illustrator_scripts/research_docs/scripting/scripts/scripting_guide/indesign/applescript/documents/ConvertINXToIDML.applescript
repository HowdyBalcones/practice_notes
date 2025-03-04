--ConvertINXToIDML.jsx
--An InDesign JavaScript
-- 
--Converts INX files to IDML by opening and re-epxorting the documents.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		-- <fragment>
		set myFileList to {}
		set myConvertRange to my myConvertDialog()
		if myConvertRange is 0 then
			-- User selected single file.
			set myFileName to choose file with prompt "Select the INX file you want to convert"
			if myFileName is not "" then
				copy myFileName to end of myFileList
			end if
		else if myConvertRange is 1 then
			-- User selected folder.
			set myFolder to choose folder with prompt "Select the folder containing the INX files you want to convert"
			tell application "Finder"
				set myFiles to every file of folder myFolder
			end tell
			--Build a list of graphics files in the folder.
			repeat with myCounter from 1 to count of items in myFiles
				set myFile to item myCounter of myFiles
				set myFileType to file type of myFile
				set myName to the name of myFile
				if myFileType is "INX" then
					copy myFile to end of myFileList
				end if
				if myFileType is missing value or myFileType is "TEXT" then
					if myName ends with ".inx" then
						copy myFile to end of myFileList
						exit repeat
					end if
				end if
			end repeat
			if (count myFileList) is greater than 0 then
				repeat with myCounter from 1 to (count myFileList)
					set myDocument to open item myCounter of myFileList
					--Create a new file name.
					set myFileName to item myCounter of myFileList
					set myFileName to my myReplace(myFileName, ".inx", ".idml")
					tell myDocument
						export format InDesign markup to myFilePath without showing options
						close saving no
					end tell
				end repeat
			end if
		else if myConvertRange is 2 then
			-- User clicked Cancel.
		end if
		-- </fragment>
	end tell
end mySnippet
on myTeardown()
end myTeardown
on myReplace(myString, myFindString, myChangeString)
	set AppleScript's text item delimiters to myFindString
	set myTextList to every text item of myString
	set AppleScript's text item delimiters to myChangeString
	set myString to myTextList as string
	set AppleScript's text item delimiters to ""
	return myString
end myReplace
on myConvertDialog()
	tell application "Adobe InDesign 2024"
		set myDialog to make dialog with properties {name:"Convert INX to IDML"}
		tell myDialog
			tell (make dialog column)
				make static text with properties {static label:"Convert a single file or a folder?"}
				set myConvertRadioButtons to make radiobutton group
				tell myConvertRadioButtons
					make radiobutton control with properties {static label:"Select file", checkedState:true}
					make radiobutton control with properties {static label:"Select folder"}
				end tell
			end tell
			set myResult to show myDialog
			if myResult is true then
				set myConvertRange to selected button of myConvertRadioButtons
			else
				set myConvertRange to 2
			end if
		end tell
		destroy myDialog
		return myConvertRange
	end tell
end myConvertDialog
