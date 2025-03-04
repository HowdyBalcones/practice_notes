--ExportAllStories.applescript
--An InCopy AppleScript
--
--Exports all stories in an InCopy document in a specified text format.
--InCopy exports each story as a separate file, and names each
--file using the story's ID.
--
--For more on InDesign/InCopy scripting see the documentation included in the Scripting SDK 
--available at http://www.adobe.com/devnet/indesign/sdk.html
--or visit the InDesign Scripting User to User forum at http://www.adobeforums.com.
--
tell application "Adobe InCopy 2024"
	if (count documents) > 0 then
		if (count stories of active document) > 0 then
			my myDisplayDialog()
		else
			display dialog "The active document contains no text. Please open a document containing text and try again."
		end if
	else
		display dialog "No documents are open. Please open a document and try again."
	end if
end tell
on myDisplayDialog()
	tell application "Adobe InCopy 2024"
		set myDialog to make dialog with properties {name:"ExportAllStories"}
		tell myDialog
			--Add a dialog column.
			tell (make dialog column)
				tell (make border panel)
					make static text with properties {static label:"Export as:"}
					set myExportFormatButtons to make radiobutton groups
					tell myExportFormatButtons
						make radiobutton control with properties {static label:"Text Only", checked state:true}
						make radiobutton control with properties {static label:"RTF"}
						make radiobutton control with properties {static label:"InDesign Tagged Text"}
					end tell
				end tell
			end tell
		end tell
		set myReturn to show myDialog
		if myReturn is true then
			--Get the values from the dialog box.
			set myExportFormat to selected button of myExportFormatButtons
			destroy myDialog
			my myExportAllStories(myExportFormat)
		else
			destroy myDialog
		end if
	end tell
end myDisplayDialog

--myExportStories function takes care of exporting the stories.
--myExportFormat is a number from 0-2, where 0 = text only, 1 = rtf, and 3 = tagged text.
--myFolder is a reference to the folder in which you want to save your files.
on myExportAllStories(myExportFormat)
	set myFolder to choose folder with prompt "Select a folder in which to store the exported files"
	if myFolder is not equal to "" then
		tell application "Adobe InCopy 2024"
			repeat with myCounter from 1 to (count stories of active document)
				set myStory to story myCounter of active document
				set myID to id of myStory
				if myExportFormat = 0 then
					set myFormat to text type
					set myExtension to ".txt"
				else if myExportFormat = 1 then
					set myFormat to RTF
					set myExtension to ".rtf"
				else if myExportFormat = 2 then
					set myFormat to tagged text
					set myExtension to ".txt"
				end if
				set myFileName to "StoryID" & myID & myExtension
				set myFilePath to (myFolder as string) & myFileName
				tell myStory
					export format myFormat to (myFilePath as string)
				end tell
			end repeat
		end tell
	end if
end myExportAllStories
