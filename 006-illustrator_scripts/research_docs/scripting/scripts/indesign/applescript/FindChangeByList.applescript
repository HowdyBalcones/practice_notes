--FindChangeByList.applescript
--An InDesign AppleScript
--
--Loads a series of tab-delimited strings from a text file, then performs a series
--of find/change operations based on the strings read from the file.
--
--The data file is tab-delimited, with carriage returns separating records.
--
--The format of each record in the file is:
--findType<tab>findProperties<tab>changeProperties<tab>findChangeOptions<tab>description
--
--Where:
--<tab> is a tab character
--findType is "text", "grep", or "glyph" (this sets the type of find/change operation to use).
--findProperties is a properties record (as text) of the find preferences.
--changeProperties is a properties record (as text) of the change preferences.
--findChangeOptions is a properties record (as text) of the find/change options.
--description is a description of the find/change operation
--
--Very simple example:
--text	{find what:"--"}	{change to:"^_"}	{include footnotes:true, include master pages:true, include hidden layers:true, whole word:false}	Find all double dashes and replace with an em dash.
--
--More complex example:
--text	{find what:"^9^9.^9^9"}	{applied character style:"price"}	{include footnotes:true, include master pages:true, include hidden layers:true, whole word:false}	Find $10.00 to $99.99 and apply the character style "price".
--
--All InDesign search metacharacters are allowed in the "find what" and "change to" properties.
--
--For more on InDesign/InCopy scripting see the documentation included in the Scripting SDK 
--available at http://www.adobe.com/devnet/indesign/sdk.html
--or visit the InDesign Scripting User to User forum at http://www.adobeforums.com
--
tell application "Adobe InDesign 2024"
	--Set the user interaction level to allow InDesign to display dialog boxes and alerts.
	set user interaction level of script preferences to interact with all
	set myTextObjects to {text, text frame, insertion point, character, word, text style range, line, paragraph, text column, cell, table, row, column}
	if (count documents) is not 0 then
		if (count stories of active document) is not 0 then
			set mySelection to selection
			if (count mySelection) is not 0 then
				if class of item 1 of mySelection is in myTextObjects then
					if class of item 1 of mySelection is text frame then
						set myObject to object reference of text 1 of item 1 of mySelection
					else if class of item 1 of mySelection is insertion point then
						set myObject to parent story of item 1 of mySelection
					else
						set myObject to item 1 of mySelection
					end if
					my myDisplayDialog(myObject, myTextObjects)
				else
					set myObject to active document
				end if
			else
				set myObject to active document
				my myFindChangeByList(myObject)
			end if
		else
			display dialog ("The current document contains no text. Please open a document containing text and try again.")
		end if
	else
		display dialog ("No documents are open. Please open a document and try again.")
	end if
end tell
on myDisplayDialog(myObject, myTextObjects)
	tell application "Adobe InDesign 2024"
		if class of myObject is insertion point then
			set myObject to parent story of myObject
		end if
		set myDialog to make dialog with properties {name:"FindChangeByList"}
		tell myDialog
			tell (make dialog column)
				set myRangeButtons to make radiobutton group
				tell myRangeButtons
					make radiobutton control with properties {static label:"Entire document", checked state:true}
					make radiobutton control with properties {static label:"Selected story"}
					if class of myObject is in myTextObjects and class of myObject is not insertion point then
						set myContents to contents of myObject
						if myContents is not equal to "" then
							make radiobutton control with properties {static label:"Selection", checked state:true}
						end if
					end if
				end tell
			end tell
		end tell
		set myResult to show myDialog
		if myResult is true then
			set myRange to selected button of myRangeButtons
			destroy myDialog
			if myRange is 0 then
				set myObject to document 1
			else if myRange is 1 then
				if class of myObject is not story then
					set myObject to parent story of myObject
				end if
			end if
			my myFindChangeByList(myObject)
		else
			destroy myDialog
		end if
	end tell
end myDisplayDialog
on myFindChangeByList(myObject)
	local myFile, myFileRef, myEOF, myFindType
	tell application "Adobe InDesign 2024"
		set myFile to my myFindFile("FindChangeSupport:FindChangeList.txt")
		set myFileRef to open for access (myFile as alias)
		set myEOF to get eof myFileRef
		set myOldDelimiters to AppleScript's text item delimiters
		--That's a tab character between the quotation marks in the next line.
		set AppleScript's text item delimiters to {"	"}
		if myEOF > 0 then
			--Delimiter is return--if you have trouble reading your find/change file, it's
			--probably because your line end characters are not Mac OS line end characters.
			set myText to read myFileRef using delimiter {return}
			close access myFileRef
			repeat with myCounter from 1 to (count myText)
				set myLine to item myCounter of myText
				if myLine starts with "text" or myLine starts with "grep" or myLine starts with "glyph" then
					if word 1 of myLine is "text" or word 1 of myLine is "grep" or word 1 of myLine is "glyph" then
						set {myFindType, myFindPreferences, myChangePreferences, myFindChangeOptions, myDescription} to text items of myLine
						if myFindType is "text" then
							my myFindText(myObject, myFindPreferences, myChangePreferences, myFindChangeOptions)
						else if myFindType is "grep" then
							my myFindGrep(myObject, myFindPreferences, myChangePreferences, myFindChangeOptions)
						else if myFindType is "glyph" then
							my myFindGlyph(myObject, myFindPreferences, myChangePreferences, myFindChangeOptions)
						end if
					end if
				end if
			end repeat
		end if
		set AppleScript's text item delimiters to myOldDelimiters
	end tell
end myFindChangeByList
on myFindText(myObject, myFindPreferences, myChangePreferences, myFindChangeOptions)
	tell application "Adobe InDesign 2024"
		--Clear the find text/change text preferences before each find/change operation.
		set find text preferences to nothing
		set change text preferences to nothing
		set myScript to "tell application \"Adobe InDesign 2024\"" & return & "set properties of find text preferences to " & myFindPreferences & return
		set myScript to myScript & "set properties of change text preferences to " & myChangePreferences & return
		set myScript to myScript & "set properties of find change text options to " & myFindChangeOptions & return
		set myScript to myScript & "end tell" & return
		do script myScript language applescript language
		tell myObject
			set myFoundItems to change text
		end tell
		--Clear the find text/change text preferences after each find/change operation.
		set find text preferences to nothing
		set change text preferences to nothing
	end tell
end myFindText
on myFindGrep(myObject, myFindPreferences, myChangePreferences, myFindChangeOptions)
	tell application "Adobe InDesign 2024"
		--Clear the find grep/change grep preferences before each find/change operation.
		set find grep preferences to nothing
		set change grep preferences to nothing
		set myScript to "tell application \"Adobe InDesign 2024\"" & return & "set properties of find grep preferences to " & myFindPreferences & return
		set myScript to myScript & "set properties of change grep preferences to " & myChangePreferences & return
		set myScript to myScript & "set properties of find change grep options to " & myFindChangeOptions & return
		set myScript to myScript & "end tell" & return
		do script myScript language applescript language
		tell myObject
			set myFoundItems to change grep
		end tell
		--Clear the find grep/change grep preferences after each find/change operation.
		set find text preferences to nothing
		set change text preferences to nothing
	end tell
end myFindGrep
on myFindGlyph(myObject, myFindPreferences, myChangePreferences, myFindChangeOptions)
	tell application "Adobe InDesign 2024"
		--Clear the find glyph/change glyph preferences before each find/change operation.
		set find glyph preferences to nothing
		set change glyph preferences to nothing
		set myScript to "tell application \"Adobe InDesign 2024\"" & return & "set properties of find glyph preferences to " & myFindPreferences & return
		set myScript to myScript & "set properties of change glyph preferences to " & myChangePreferences & return
		set myScript to myScript & "set properties of find change glyph options to " & myFindChangeOptions & return
		set myScript to myScript & "end tell" & return
		do script myScript language applescript language
		tell myObject to change glyph
		--Clear the find glyph/change glyph preferences after each find/change operation.
		set find text preferences to nothing
		set change text preferences to nothing
	end tell
end myFindGlyph
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
			set myFileName to choose file with prompt "Locate your find/change file"
		end if
	end tell
	return myFileName
end myFindFile
