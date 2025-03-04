--ExportEachPageAsEPS.applescript
--An InDesign AppleScript
--
--Exports each page of a document as EPS to a specified folder.
--Display a "choose folder" dialog box.
main()
to main()
	mySetup()
	mySnippet()
	myTeardown()
end main
to mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		set myDesktopFolder to path to desktop as string
		set myFile to myDesktopFolder & "ExportEachPageAsEPS.indd"
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
to mySnippet()
	--![Export each page to EPS.]
	--Exports each page of an InDesign document as a separate PDF to a
	--selected folder using the current PDF export settings.
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		set myFolder to my myChooseFolder()
		if myFolder is not equal to "" then
			my myExportPages(myFolder)
		end if
	end tell
	![Export each page to EPS.]
end mySnippet
to myTeardown()
end myTeardown
![Export each page to EPS - functions.]
on myChooseFolder()
	set myFolder to choose folder with prompt "Choose a Folder"
	--Get the folder name (it'll be returned as a Unicode string)
	set myFolder to myFolder as string
	return myFolder
end myChooseFolder
on myExportPages(myFolder)
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		set myDocumentName to name of myDocument
		set myDialog to make dialog with properties {name:"ExportPages"}
		tell myDialog
			tell (make dialog column)
				tell (make dialog row)
					make static text with properties {static label:"Base Name:"}
					set myBaseNameField to make text editbox with properties {edit contents:myDocumentName, min width:160}
				end tell
			end tell
		end tell
		set myResult to show myDialog
		if myResult is true then
			--The name of the exported files will be the base name + the value of
			--the counter + ".pdf".
			set myBaseName to edit contents of myBaseNameField
			--Remove the dialog box from memory.
			destroy myDialog
			repeat with myCounter from 1 to (count pages in myDocument)
				--Get the name of the page and assign it to the variable "myPageName"
				set myPageName to name of page myCounter of myDocument
				--Set the page range to the name of the specific page.
				set page range of EPS export preferences to myPageName
				--Generate a file path from the folder name, the base document name,
				--and the page name.
				--Replace any colons in the page name (e.g., "Sec1:1") so that they
				--don't cause problems with file naming.
				set myPageName to my myReplace(myPageName, ":", "_")
				set myFilePath to myFolder & myBaseName & "_" & myPageName & ".eps"
				tell myDocument
					export format EPS type to myFilePath without showing options
				end tell
			end repeat
		else
			destroy myDialog
		end if
	end tell
end myExportPages
on myReplace(myString, myFindString, myChangeString)
	set AppleScript's text item delimiters to myFindString
	set myTextList to every text item of myString
	set AppleScript's text item delimiters to myChangeString
	set myString to myTextList as string
	set AppleScript's text item delimiters to ""
	return myString
end myReplace
--![Export each page to EPS - functions.]

