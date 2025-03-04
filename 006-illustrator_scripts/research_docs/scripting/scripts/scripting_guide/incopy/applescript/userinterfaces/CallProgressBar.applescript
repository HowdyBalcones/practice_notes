--CallProgressBar.applescripttell application "Adobe InCopy 2024"tell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Displays a ScriptUI progress bar created by the
--ProgressBar.jsx example script.
tell application "Adobe InCopy 2024"
	set mySetupScriptFile to my myFindFile("ProgressBar.jsx", "Locate the file ProgressBar.jsx")
	do script mySetupScriptFile language javascript
	--Create a document and add pages to it--
	--if you don't do this, the progress bar will
	--go by too quickly.
	set myDocument to make document
	--Note that the JavaScripts must use the "session"
	--engine for this to work.
	set myJavaScript to "#targetengine \"session\"" & return
	set myJavaScript to myJavaScript & "myCreateProgressPanel(20, 400);" & return
	set myJavaScript to myJavaScript & "myProgressPanel.show();" & return
	do script myJavaScript language javascript
	repeat with myCounter from 1 to 20
		set myJavaScript to "#targetengine \"session\"" & return
		set myJavaScript to myJavaScript & "myProgressPanel.myProgressBar.value = "
		set myJavaScript to myJavaScript & myCounter & "/myIncrement;" & return
		do script myJavaScript language javascript
		tell story 1 of myDocument
			set the contents of insertion point -1 to "This is a paragraph." & return
		end tell
	end repeat
	set myJavaScript to "#targetengine \"session\"" & return
	set myJavaScript to myJavaScript & "myProgressPanel.myProgressBar.value = 0;" & return
	set myJavaScript to myJavaScript & "myProgressPanel.hide();" & return
	do script myJavaScript language javascript
end tell
on myFindFile(myFindFileName, myString)
	tell application "Adobe InCopy 2024"
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
			set myFileName to choose file with prompt myString
		end if
	end tell
	return myFileName
end myFindFile

