--DoScriptReturnValues.applescript
--An InDesign AppleScript
--
--Shows how to get values back from a script run using the do script command.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		set myPage to page 1 of myDocument
		tell myPage
			set myTextFrame to make text frame
		end tell
		set geometric bounds of myTextFrame to {"72pt", "72pt", "288pt", "288pt"}
		set contents of myTextFrame to "Example text frame."
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		--![Returning values from do script.]
		set myDocument to document 1
		set myPage to page 1 of myDocument
		set myTextFrame to text frame 1 of myPage
		tell myDocument
			set myDestinationPage to make page
		end tell
		set myPageIndex to name of myDestinationPage
		set myID to id of myTextFrame
		set myJavaScript to "var myDestinationPage = arguments[1];" & return
		set myJavaScript to myJavaScript & "myID = arguments[0];" & return
		set myJavaScript to myJavaScript & "var myX = arguments[2];" & return
		set myJavaScript to myJavaScript & "var myY = arguments[3];" & return
		set myJavaScript to myJavaScript & "var myPageItem = app.documents.item(0).pages.item(0).pageItems.itemByID(myID);" & return
		set myJavaScript to myJavaScript & "myPageItem.duplicate(app.documents.item(0).pages.item(myDestinationPage));" & return
		--Create an array for the parameters we want to pass to the JavaScript.
		set myArguments to {myID, myPageIndex, 0, 0}
		set myDuplicate to do script myJavaScript language javascript with arguments myArguments
		--myDuplicate now contains a reference to the duplicated text frame.
		--Change the text in the duplicated text frame.
		set contents of myDuplicate to "Duplicated text frame."
		--![Returning values from do script.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
