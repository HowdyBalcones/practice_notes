--ImprovedHello World.applescript
tell application "InDesignServer"
	set myDocument to make document
	set myPage to page 1 of myDocument
	tell myPage
		set myTextFrame to make text frame
	end tell
	set contents of myTextFrame to "Hello World!"
	--Get page width and page height using the function "myGetBounds".
	set myBounds to my myGetBounds(myDocument, myPage)
	--Resize the text frame to match the publication margins.
	set geometric bounds of myTextFrame to myBounds
	set myParagraph to object reference of paragraph 1 of myTextFrame
	--Change the font, size, and alignment.
	--Enter the name of a font on your system, if necessary.
	try
		set myFont to font "Arial" of application "InDesignServer"
		set applied font of myParagraph to myFont
	end try
	
	--Change the size of the text.
	set point size of myParagraph to 48
	
	--Set the justification of the paragraph to center align.
	set justification of myParagraph to center align
	
	--Set the first baseline offset of the text frame to ascent.
	set first baseline offset of text frame preferences of myTextFrame to ascent offset
	
	--Set the vertical justification of the text frame to center.
	set vertical justification of text frame preferences of myTextFrame to center align
	
	--Export the document as PDF (fill in a valid file path).
	tell myDocument
		tell application "Finder"
			set myFile to (startup disk as string) & "ServerTestFiles:ImprovedHelloWorld.pdf"
		end tell
		export format PDF type to myFile
	end tell
	--Close the document.
	close document 1
end tell
on myGetBounds(myDocument, myPage)
	tell application "InDesignServer"
		set myPageHeight to page height of document preferences of myDocument
		set myPageWidth to page width of document preferences of myDocument
		set myMarginPreferences to margin preferences of myPage
		set myTop to top of myMarginPreferences
		set myLeft to left of myMarginPreferences
		set myRight to right of myMarginPreferences
		set myBottom to bottom of myMarginPreferences
		set myRight to myPageWidth - myRight
		set myBottom to myPageHeight - myBottom
		return {myTop, myLeft, myBottom, myRight}
	end tell
end myGetBounds
