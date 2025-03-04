--MetadataExample.applescript
--An InDesign Server AppleScript
--Creates an example document and adds metadata to it.
tell application "InDesignServer"
	set myDocument to make document
	tell metadata preferences of myDocument
		set author to "Olav Martin Kvern"
		set copyright info URL to "http://www.adobe.com"
		set copyright notice to "This document is copyrighted."
		set copyright status to yes
		set description to "Example of xmp metadata scripting in InDesign"
		set document title to "XMP Example"
		set job name to "XMP_Example_2004"
		set keywords to {"animal", "mineral", "vegetable"}
		--The metadata preferences object also includes the read-only
		--creator, format, creationDate, modificationDate, and serverURL properties that are
		--automatically entered and maintained by InDesign.
		--Create a custom XMP container, "email"
		set myNewContainer to create container item namespace "http://ns.adobe.com/xap/1.0/" path "email"
		set property namespace "http://ns.adobe.com/xap/1.0/" path "email/*[1]" value "okvern@adobe.com"
	end tell
	tell application "Finder"
		set myFile to (startup disk as string) & "ServerTestFiles:myTestDocument.indd"
	end tell
	set myDocument to save myDocument to myFile
	--Close the document
	close myDocument
end tell
