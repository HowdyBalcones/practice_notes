Rem FindText.vbs
Rem An InCopy VBScript
Rem
Rem Shows how to find text.
main
Function main()
	Set myInCopy = CreateObject("InCopy.Application.2024")
	mySetup myInCopy
	mySnippet myInCopy
	myTeardown myInCopy
End Function
Function mySetup(myInCopy)
	Set myDocument = myInCopy.Documents.Add
	Set myStory = myDocument.Stories.Item(1)
	Rem Fill the text frame with placeholder text.
	myString = "This is some text. This is some more text. This is even more example text.\rThis is text in another paragraph."
	myStory.Contents = myString
End Function
Function mySnippet(myInCopy)
	Rem Clear the find/change preferences.
	myInCopy.FindTextPreferences = idNothingEnum.idNothing
	myInCopy.ChangeTextPreferences = idNothingEnum.idNothing
	Rem Search the document for the string "Text".
	myInCopy.FindTextPreferences.FindWhat = "text"
	Rem Set the find options.
	myInCopy.FindChangeTextOptions.CaseSensitive = False
	myInCopy.FindChangeTextOptions.IncludeFootnotes = False
	myInCopy.FindChangeTextOptions.IncludeHiddenLayers = False
	myInCopy.FindChangeTextOptions.IncludeLockedLayersForFind = False
	myInCopy.FindChangeTextOptions.IncludeLockedStoriesForFind = False
	myInCopy.FindChangeTextOptions.IncludeMasterPages = False
	myInCopy.FindChangeTextOptions.WholeWord = False
	Set myFoundItems = myInCopy.Documents.Item(1).FindText
	MsgBox ("Found " & CStr(myFoundItems.Count) & " instances of the search string.")
	myInCopy.FindTextPreferences = idNothingEnum.idNothing
	myInCopy.ChangeTextPreferences = idNothingEnum.idNothing
End Function
Function myTeardown(myInCopy)
End Function