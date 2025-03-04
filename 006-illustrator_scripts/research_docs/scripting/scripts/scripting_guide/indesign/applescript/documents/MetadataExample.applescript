--MetadataExample.applescript
--An InDesign AppleScript
--
--Creates an example document and adds metadata to it.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024" to make document
end mySetup
on mySnippet()
	--Creates an example document and adds metadata to it.
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Add XMP metadata.]
		--Given a document "myDocument"...
		tell metadata preferences of myDocument
			set author to "Adobe"
			set copyright info URL to "http://www.adobe.com"
			set copyright notice to "This document is copyrighted."
			set copyright status to yes
			set description to "Example of xmp metadata scripting in InDesign CC"
			set document title to "XMP Example"
			set job name to "XMP_Example_2008"
			set keywords to {"animal", "mineral", "vegetable"}
			--The metadata preferences object also includes the read-only
			--creator, format, creationDate, modificationDate, and server URL
			--properties that are automatically entered and maintained by
			--InDesign.
			--Create a custom XMP container, "email"
			set myS to "http://ns.adobe.com/xap/1.0/"
			set myNewContainer to create container item namespace myS path "email"
			set property namespace myS path "email/*[1]" value "someone@adobe.com"
		end tell
		--![Add XMP metadata.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
