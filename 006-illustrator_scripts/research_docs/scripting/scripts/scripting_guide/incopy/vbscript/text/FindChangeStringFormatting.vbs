Rem FindChangeStringFormatting.vbs
Rem An InCopy VBScript
Rem
Rem Shows how to find and change text formatting.
main
Function main()
	Set myInCopy = CreateObject("InCopy.Application.2024")
	mySetup myInCopy
	mySnippet myInCopy
	myTeardown myInCopy
End Function
Function mySetup(myInCopy)
	Set myDocument = myInCopy.Documents.Add
	Rem Create a text frame on page 1.
	Set myStory = myDocument.Stories.Item(1)
	myString = "Widget A. PartNumber: WIDGET0001" & vbCr & "Widget B. PartNumber: WIDGET0002" & vbCr & "Widget C. PartNumber:WIDGET0003" & vbCr & "Widget D. PartNumber:WIDGET1234" & vbCr
	myStory.Contents = myString
End Function
Function mySnippet(myInCopy)
	Set myDocument = myInCopy.Documents.Item(1)
	Rem Clear the find/change preferences before the search.
	myInCopy.FindTextPreferences = idNothingEnum.idNothing
	myInCopy.ChangeTextPreferences = idNothingEnum.idNothing
	Rem Set the general find/change options.
	myInCopy.findChangeTextOptions.caseSensitive = false
	myInCopy.findChangeTextOptions.includeFootnotes = false
	myInCopy.findChangeTextOptions.includeHiddenLayers = false
	myInCopy.findChangeTextOptions.includeLockedLayersForFind = false
	myInCopy.findChangeTextOptions.includeLockedStoriesForFind = false
	myInCopy.findChangeTextOptions.includeMasterPages = false
	myInCopy.findChangeTextOptions.wholeWord = false 
	Rem The following line will only work if your default 
	Rem font has a font style named "Bold" if not, change 
	Rem the text to a font style used by your default font.
	myInCopy.ChangeTextPreferences.FontStyle = "Bold"
	Rem In this example, we'll use the InDesign search 
	Rem metacharacter "^9" to find any digit.
	myInCopy.FindTextPreferences.FindWhat = "WIDGET^9^9^9^9"
	set myFoundItems = myDocument.ChangeText
	MsgBox ("Changed " & CStr(myFoundItems.Count) & " instances of the search string.")
	Rem Clear the find/change preferences after the search.
	myInCopy.FindTextPreferences = idNothingEnum.idNothing
	myInCopy.ChangeTextPreferences = idNothingEnum.idNothing
End Function
Function myTeardown(myInCopy)
End Function