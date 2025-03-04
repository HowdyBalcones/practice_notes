Rem ChangeText.vbs
Rem An InCopy VBScript
Rem
Rem Shows how to find and change text.
main
Function main()
	Set myInCopy = CreateObject("InCopy.Application.2024")
	mySetup myInCopy
	mySnippet myInCopy
	myTeardown myInCopy
End Function
Function mySetup(myInCopy)
	Rem Create an example document.
	Set myDocument = myInCopy.Documents.Add
	Set myStory = myDocument.Stories.Item(1)
	Rem Fill the text frame with placeholder text.
	myString = "This is some copy. This is some more copy. This is even more example copy.\rThis is copy in another paragraph."
	myStory.Contents = myString
End Function
Function mySnippet(myInCopy)
	Rem <fragment>
	Rem Clear the find/change preferences.
	myInCopy.FindTextPreferences = idNothingEnum.idNothing
	myInCopy.ChangeTextPreferences = idNothingEnum.idNothing
	Rem Search the document for the string "copy" and replace with "text".
	myInCopy.FindTextPreferences.FindWhat = "copy"
	myInCopy.ChangeTextPreferences.ChangeTo = "text"
	Rem Set the find options.
	myInCopy.FindChangeTextOptions.CaseSensitive = False
	myInCopy.FindChangeTextOptions.IncludeFootnotes = False
	myInCopy.FindChangeTextOptions.IncludeHiddenLayers = False
	myInCopy.FindChangeTextOptions.IncludeLockedLayersForFind = False
	myInCopy.FindChangeTextOptions.IncludeLockedStoriesForFind = False
	myInCopy.FindChangeTextOptions.IncludeMasterPages = False
	myInCopy.FindChangeTextOptions.WholeWord = False
	Set myFoundItems = myInCopy.Documents.Item(1).ChangeText
	myInCopy.FindTextPreferences = idNothingEnum.idNothing
	myInCopy.ChangeTextPreferences = idNothingEnum.idNothing
	Rem </fragment>
End Function
Function myTeardown(myInCopy)
End Function