--SaveAsTemplate.applescript
--An InDesign AppleScript
--
--Save the active document as a template.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDesktopFolder to path to desktop as string
		set myFile to myDesktopFolder & "SaveDocumentAsTemplateExample.indd"
		set myDocument to make document
		save myDocument to myFile
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDesktopFolder to path to desktop as string
		set myFile to myDesktopFolder & "SaveDocumentAsTemplateExample.indd"
		set myDocument to open myFile
		--![Save as template.]
		tell myDocument
			if saved is true then
				--Convert the file name to a string.
				set myFileName to full name
				set myFileName to my myReplace(myFileName, ".indd", ".indt")
			else
				--If the document has not been saved, then give it a default file
				--name/file path. You'll have to fill in the file path in the variable "myPath".
				set myFileName to my myReplace(myPath, ".indd", ".indt")
				set myFileName to myPath
			end if
			save to myFileName with stationery
		end tell
		--![Save as template.]
	end tell
end mySnippet
to myTeardown()
end myTeardown
on myReplace(myString, myFindString, myChangeString)
	set AppleScript's text item delimiters to myFindString
	set myTextList to every text item of (myString as string)
	set AppleScript's text item delimiters to myChangeString
	set myString to myTextList as string
	set AppleScript's text item delimiters to ""
	return myString
end myReplace
