--ImportTextStyles.applescript
--An InDesign AppleScript
--
--Shows how to import paragraph styles and character styles from another document.
my main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set user name to "Adobe"
		--Create an example document.
		set myDocument to make document
		tell myDocument
			--Create a paragraph style named "myParagraphStyleA" if no 
			--style by that name already exists.
			try
				set myParagraphStyleA to paragraph style "myParagraphStyleA"
			on error
				--The paragraph style did not exist, so create it.
				set myParagraphStyleA to make paragraph style with properties {name:"myParagraphStyleA"}
			end try
			--Create another paragraph style.
			try
				set myParagraphStyleB to paragraph style "myParagraphStyleB"
			on error
				--The paragraph style did not exist, so create it.
				set myParagraphStyleB to make paragraph style with properties {name:"myParagraphStyleB"}
			end try
			--Create a character style named "myCharacterStyle" if 
			--no style by that name already exists.
			try
				set myCharacterStyle to character style "myCharacterStyle"
			on error
				--The style did not exist, so create it.
				set myCharacterStyle to make character style with properties {name:"myCharacterStyle"}
			end try
			--Save the document (you'll have to fill in a valid file path for your system).
			set myFilePath to "Macintosh HD:scripting:styles.indd"
			close saving yes saving in myFilePath
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		--![Import text styles.]
		--You'll have to fill in a valid file path for your system.
		set myFilePath to "Macintosh HD:scripting:styles.indd"
		--Create a new document.
		set myDocument to make document
		tell myDocument
			--Import the styles from the saved document.
			--importStyles parameters:
			--Format options for text styles are:
			--    paragraph styles format
			--    character styles format
			--    text styles format
			--From as file or string
			--Global Strategy options are:
			--    do not load the style
			--    load all with overwrite
			--    load all with rename
			import styles format text styles format from myFilePath global strategy load all with overwrite
		end tell
		--![Import text styles.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
