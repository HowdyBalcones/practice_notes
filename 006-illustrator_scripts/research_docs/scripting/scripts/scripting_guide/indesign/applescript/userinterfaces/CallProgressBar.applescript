--CallProgressBar.applescript
--An InDesign AppleScript
--
--Displays a ScriptUI progress bar created by the
--ProgressBar.jsx example script.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	--<fragment>
	tell application "Adobe InDesign 2024"
		set mySetupScriptFile to my myFindFile("ProgressBar.jsx", "Locate the file ProgressBar.jsx")
		do script mySetupScriptFile language javascript
	end tell
	--</fragment>
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		--![Call progress bar.]
		set myDocument to make document
		--Add pages to the active document.
		--If you don't do this, the progress bar will
		--go by too quickly.
		--Note that the JavaScripts must use the "session"
		--engine for this to work.
		set myJavaScript to "#targetengine \"session\"" & return
		set myJavaScript to myJavaScript & "myCreateProgressPanel(100, 400);" & return
		set myJavaScript to myJavaScript & "myProgressPanel.show();" & return
		do script myJavaScript language javascript
		repeat with myCounter from 1 to 40
			set myJavaScript to "#targetengine \"session\"" & return
			set myJavaScript to myJavaScript & "myProgressPanel.myProgressBar.value = "
			set myJavaScript to myJavaScript & myCounter & "/myIncrement;" & return
			do script myJavaScript language javascript
			tell myDocument to make page
			if myCounter = 100 then
				set myJavaScript to "#targetengine \"session\"" & return
				set myJavaScript to myJavaScript & "myProgressPanel.myProgressBar.value = 0;" & return
				set myJavaScript to myJavaScript & "myProgressPanel.hide();" & return
				do script myJavaScript language javascript
				close myDocument saving no
			end if
		end repeat
		--![Call progress bar.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
on myFindFile(myFindFileName, myString)
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
			set myFileName to choose file with prompt myString
		end if
	end tell
	return myFileName
end myFindFile
